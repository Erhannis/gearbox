use <deps.link/erhannisScad/misc.scad>
use <deps.link/getriebe/Getriebe.scad>

/**
I recommend printing all these with
Horizontal Expansion: -0.08
Initial Layer Horizontal Expansion: -0.3

Otherwise they are way too tight to even fit together.
*/

/**
If smallSun(drive=true), then the gear ratio is higher than if largeSun(drive=true).
(Only one should drive, or you get a crash.  Haha.)
*/

$fn=60;
$BIG = 1000;

SZ = 5;
SZ_GAP = 2;

IND_W = 2;
IND_D = 2;

RING_D = 44;
SHEATH_W = 6;
GROOVE_D = 2;
CUT_W = 0.5;
SCALE = 5/4;

BIG_FACTOR = 4;

// 36 ring, 12 shaft, 12 sun
// 38 ring, 14 shaft, 10 sun

//TODO I should probably parameterize these modules at some point

module grooves(big=false) {
    bf = big ? BIG_FACTOR : 1;
    for (i = [1:8]) {
        rotate([0,0,i*45])
            translate([RING_D/2,0,0])
            cylinder(d=GROOVE_D,h=SZ*bf);
    }
}

module smallRing(big=false) {
    bf = big ? BIG_FACTOR : 1;
    difference() {
        scale(SCALE) union() { // Small ring (36)
            if (big) {
                for (i = [0:BIG_FACTOR-1]) {
                    translate([0,0,i*SZ])
                        pfeilhohlrad(modul=1, zahnzahl=36, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
                }
            } else {
                pfeilhohlrad(modul=1, zahnzahl=36, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
            }
            dims = pfeilhohlrad_dims(modul=1, zahnzahl=36, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
            difference() {
                cylinder(d=RING_D, h=SZ*bf);
                cylinder(d=dims[1], h=SZ*bf);
            }
            grooves(big=big);
        }
        translate([0,-CUT_W/2,0]) cube([$BIG,CUT_W,$BIG]);
    }
}

module largeRing(big=false) {
    bf = big ? BIG_FACTOR : 1;
    difference() {
        scale(SCALE) union() { // Large ring (38)
            if (big) {
                for (i = [0:BIG_FACTOR-1]) {
                    translate([0,0,i*SZ])
                        pfeilhohlrad(modul=1, zahnzahl=38, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
                }
            } else {
                pfeilhohlrad(modul=1, zahnzahl=38, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
            }
            dims = pfeilhohlrad_dims(modul=1, zahnzahl=38, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
            difference() {
                cylinder(d=RING_D, h=SZ*bf);
                cylinder(d=dims[1], h=SZ*bf);
            }
            grooves(big=big);
        }
        translate([0,-CUT_W/2,0]) cube([$BIG,CUT_W,$BIG]);
    }
}

module sheath(big=false) {
    bf = big ? BIG_FACTOR : 1;
    scale(SCALE) difference() { // Sheath ; print 2 of these
        cylinder(d=RING_D+SHEATH_W,h=SZ*bf);
        cylinder(d=RING_D,h=SZ*bf);
        grooves(big=big);
    }
}

module shaft(small_big=false, big_big=false) {
    sbf = small_big ? BIG_FACTOR : 1;
    bbf = big_big ? BIG_FACTOR : 1;
    scale(SCALE) difference() { // Shaft 14/12 ; print 4 of these
        union() {
            if (big_big) {
                difference() {
                    pfeilrad(modul=1, zahnzahl=14, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
                    OZp([0,0,SZ+SZ_GAP/2]);
                }
                for (i = [1:1:BIG_FACTOR-2]) {
                    translate([0,0,SZ*i+SZ_GAP/2])
                        pfeilrad(modul=1, zahnzahl=14, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
                }
                translate([0,0,SZ*(BIG_FACTOR-1)+SZ_GAP/2]) difference() {
                    translate([0,0,-SZ_GAP/2]) pfeilrad(modul=1, zahnzahl=14, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
                    OZm();
                }
            } else {
                pfeilrad(modul=1, zahnzahl=14, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
            }
            if (small_big) {
                translate([0,0,SZ*bbf+SZ_GAP]) {
                    difference() {
                        pfeilrad(modul=1, zahnzahl=12, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=-30, optimiert=false);
                        OZp([0,0,SZ+SZ_GAP/2]);
                    }
                    for (i = [1:1:BIG_FACTOR-2]) {
                        translate([0,0,SZ*i+SZ_GAP/2])
                            pfeilrad(modul=1, zahnzahl=12, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=-30, optimiert=false);
                    }
                    translate([0,0,SZ*(BIG_FACTOR-1)+SZ_GAP/2]) difference() {
                        translate([0,0,-SZ_GAP/2]) pfeilrad(modul=1, zahnzahl=12, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=-30, optimiert=false);
                        OZm();
                    }
                }
            } else {
                translate([0,0,SZ*bbf+SZ_GAP]) pfeilrad(modul=1, zahnzahl=12, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=-30, optimiert=false);
            }
        }
        translate([0,0,(SZ*sbf+SZ_GAP)+(SZ*bbf+SZ_GAP)]) {
            cube([$BIG, IND_W, IND_D], center=true);
            translate([IND_W,0,0]) cylinder(d=2*IND_W,h=IND_D, center=true);
        }
    }
}

module smallSun(drive=true, big=false) {
    difference() {
        scale(SCALE) union() { // Small sun (10)
            if (big) {
                pfeilrad(modul=1, zahnzahl=10, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
                for (i = [1:1:BIG_FACTOR-2]) {
                    translate([0,0,SZ*i])
                        pfeilrad(modul=1, zahnzahl=10, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
                }
                translate([0,0,SZ*(BIG_FACTOR-1)])
                    pfeilrad(modul=1, zahnzahl=10, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
            } else {
                pfeilrad(modul=1, zahnzahl=10, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
            }
        }
        if (drive) {
            flattedShaft(h=$BIG,r=2.5 + 0.15,center=true);
        } else {
            cylinder(h=$BIG,r=2.7,center=true);
        }
    }
}

module largeSun(drive=false, big=false) {
    difference() {
        scale(SCALE) union() { // Large sun (12)
            if (big) {
                pfeilrad(modul=1, zahnzahl=12, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
                for (i = [1:1:BIG_FACTOR-2]) {
                    translate([0,0,SZ*i])
                        pfeilrad(modul=1, zahnzahl=12, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
                }
                translate([0,0,SZ*(BIG_FACTOR-1)])
                    pfeilrad(modul=1, zahnzahl=12, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
            } else {
                pfeilrad(modul=1, zahnzahl=12, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
            }
        }
        if (drive) {
            flattedShaft(h=$BIG,r=2.5 + 0.15,center=true);
        } else {
            cylinder(h=$BIG,r=2.7,center=true);
        }
    }
}

* smallRing();
* largeRing();
* sheath();
* shaft();
* smallSun();
* largeSun();