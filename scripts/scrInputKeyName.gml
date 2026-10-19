/*
input text change (added): the keyboard name of an input (scrInputCode's codes): the key it's set to in Set Controls,
or the menus' fixed keys (P, M, J, K, L; the title screen's W / S).
argument0: input code
*/
var c,k;
c=argument0
k=""
if c=1 {k=global.ctrlLeft}
else if c=2 {k=global.ctrlRight}
else if c=3 {k=global.ctrlUp}
else if c=4 {k=global.ctrlDown}
else if c=5 {k=global.ctrlJump}
else if c=6 {k=global.ctrlFire}
else if c=7 {k=global.ctrlWater}
else if c=8 {k=global.ctrlWind}
else if c=9 {k=global.ctrlEarth}
else if c=10 {k=global.ctrlDashLeft}
else if c=11 {k=global.ctrlDashRight}
else if c=12 {k="P"}
else if c=13 {k="M"}
else if c=14 {k="J"}
else if c=15 {k="K"}
else if c=16 {k="L"}
else if c=103 {k="W"}
else if c=104 {k="S"}
k=string_upper(string(k))
if k=" " {k="Space"}
return k
