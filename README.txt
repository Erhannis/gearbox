OpenSCAD planetary gearbox.  Repo at https://github.com/Erhannis/gearbox .  A port of one of Gear Down For What's gearboxes: https://www.thingiverse.com/thing:2054378 .  His is licensed under CC/A/SA ; I don't know what that makes mine.  Mine is otherwise MIT licensed.

Run get_deps.sh to get the dependencies from github.  If you're running windows, install git, make a "deps.link" folder where you have the gearbox scad, then in that folder run the "git clone" lines of the "get_deps.sh" file.  OpenSCAD should be able to read gearbox.scad properly, then.

Printing: I used 0.2 layer height, 20% infill.  Cura's "Standard Quality" setting.  (Skirt, not brim.)  BUT, by default it's far too tight a fit.  I've discovered that Cura's "Horizontal Expansion" setting sorta makes it as if you dipped your piece in wax or in acid, for positive and negative values, respectively; it's pretty great as an "auto-tolerance" setting.  I found between -0.08 (slightly too tight) and -0.1 (slightly too loose) to be good on my printer.  Note that if you aren't careful, Horizontal Expansion can eat through pieces if they were already thin and you set it too high (negative).

-Erhannis
