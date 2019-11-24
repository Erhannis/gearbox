use <deps.link/erhannisScad/misc.scad>
use <deps.link/getriebe/Getriebe.scad>

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

// 36 ring, 12 shaft, 12 sun
// 38 ring, 14 shaft, 10 sun

module joiner() {
    for (i = [1:8]) {
        rotate([0,0,i*45])
            translate([RING_D/2,0,0])
            cylinder(d=GROOVE_D,h=SZ);
    }
}

* difference() {
    scale(SCALE) union() { // Small ring (36)
        pfeilhohlrad(modul=1, zahnzahl=36, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
        dims = pfeilhohlrad_dims(modul=1, zahnzahl=36, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
        difference() {
            cylinder(d=RING_D, h=SZ);
            cylinder(d=dims[1], h=SZ);
        }
        joiner();
    }
    translate([0,-CUT_W/2,0]) cube([$BIG,CUT_W,$BIG]);
}

* difference() {
    scale(SCALE) union() { // Large ring (38)
        pfeilhohlrad(modul=1, zahnzahl=38, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
        dims = pfeilhohlrad_dims(modul=1, zahnzahl=38, breite=SZ, randbreite=0.1, eingriffswinkel=20, schraegungswinkel=30);
        difference() {
            cylinder(d=RING_D, h=SZ);
            cylinder(d=dims[1], h=SZ);
        }
        joiner();
    }
    translate([0,-CUT_W/2,0]) cube([$BIG,CUT_W,$BIG]);
}

scale(SCALE) difference() { // Sheathe ; print 2 of these
    cylinder(d=RING_D+SHEATH_W,h=SZ);
    cylinder(d=RING_D,h=SZ);
    joiner();
}


* scale(SCALE) difference() { // Shaft 14/12 ; print 4 of these
    union() {
        pfeilrad(modul=1, zahnzahl=14, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
        translate([0,0,SZ+SZ_GAP]) pfeilrad(modul=1, zahnzahl=12, breite=SZ+SZ_GAP, bohrung=0, eingriffswinkel=20, schraegungswinkel=-30, optimiert=false);
    }
    translate([0,0,2*(SZ+SZ_GAP)]) {
        cube([$BIG, IND_W, IND_D], center=true);
        translate([IND_W,0,0]) cylinder(d=2*IND_W,h=IND_D, center=true);
    }
}

* difference() {
    scale(SCALE) union() { // Small sun (10)
        pfeilrad(modul=1, zahnzahl=10, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
    }
    cylinder(h=40,r=3,center=true);
}

* difference() {
    scale(SCALE) union() { // Large sun (12)
        pfeilrad(modul=1, zahnzahl=12, breite=SZ, bohrung=0, eingriffswinkel=20, schraegungswinkel=30, optimiert=false);
    }
    flattedShaft(h=40,r=2.5 + 0.15,center=true);
}