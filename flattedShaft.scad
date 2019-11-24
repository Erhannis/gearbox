use <deps.link/erhannisScad/misc.scad>
use <deps.link/getriebe/Getriebe.scad>

$fn=60;
$BIG = 1000;

flattedShaft(h=30,r=2.5);
pfeilrad(modul=4, zahnzahl=7, breite=5, bohrung=0, eingriffswinkel=25, schraegungswinkel=30, optimiert=false);