
// baseless boxes with rounded vertical edges and chamfered top
$fn=50;
l=80; w=60; radius=12;    // overall dimensions and corner radius
d=40; plinth=25;    // vertical walls form the plinth
t=2; taper=6;    // thickness;  width of chamfer around the top

module rrect(l,w,r) {    // rounded filled rectangle
    offset(r) offset(delta=-r) square([l,w],true); }

module rrectwall(l,w,t,r) {    // rounded hollow rectangle
    // inner rectangle dims are [l-3r,w-3r] approx
    difference() {
        rrect(l,w,r);
        scale([(l-2*t)/l, (w-2*t)/w, 1]) rrect(l,w,r); }; }

module rbox(l,w,d,t,r,taper) {    // tapered box walls with verticals rounded, z +ve
    scaling=[(l-2*taper)/l, (w-2*taper)/w];
    linear_extrude(height=d, center=false, convexity=10, scale=scaling)
        rrectwall(l,w,t,r); }

// box with rounded vertical edges and evenly chamfered top
#rbox(l,w,plinth,t,radius,0);
#translate([0,0,plinth]) rbox(l,w,d-plinth,t,radius,taper);

// closed rounded box with chamfer tapering to a rectangular top
*hull() {
    rbox(l,w,plinth,t,radius,0);
    translate([0,0,d]) cube([l-2*taper,w-2*taper,0.001],true); };

// rounded box with tapered base
*translate([0,0,plinth]) {
    mirror([0,0,1]) rbox(l,w,plinth,t,radius,taper);
    rbox(l,w,d-plinth,t,radius,0); }

// rounded box including tapered foot in overall dims
translate([0,0,plinth]) {
    mirror([0,0,1]) rbox(l-2*taper,w-2*taper,plinth,t,radius,-taper);
    rbox(l-2*taper,w-2*taper,d-plinth,t,radius,0); }

// rounded box plus tapered foot
*translate([0,0,plinth]) {
    mirror([0,0,1]) rbox(l,w,plinth,t,radius,-taper);
    rbox(l,w,d-plinth,t,radius,0); }

