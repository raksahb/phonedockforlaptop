phoneFrontCameraAreaHeight = 15;
phoneWidth = 80;
phoneHeight = 155;
dockThickness = 1.5;
dockHeight = phoneHeight - phoneFrontCameraAreaHeight;
padding = 4;
dockBandWidth = 5;
dockWidth = phoneWidth + padding + (2 * dockBandWidth);
dockBaseLipWidth = dockBandWidth * 1.5;
dockBaseFrontLipWidth = dockBandWidth * 1.3;
dockBaseWidth = 2 * dockBandWidth;
usbOpeningWidth = 30;
usbOpeningStart = (dockWidth - usbOpeningWidth) / 2;
dockStrapGap = phoneWidth + padding + dockBandWidth;
dockSupportHeight = 110;
phoneSupportHeight = phoneHeight - dockSupportHeight + dockThickness;

module singleStrap(length, width = dockBandWidth, thickness = dockThickness) {
    cube([length, width, thickness]);
}

module dockBase(width) {
    rotate([90, 0, 90]) singleStrap(width, width = 2 * dockBandWidth);
}

module usbOpening(width=usbOpeningWidth) {
    thickerBy = 3;
    rotate([90, 0, 90]) singleStrap(length = width, width = dockBaseWidth + 2 * dockThickness, thickness = dockThickness * thickerBy);
}

module hook() {
    dockBase(dockBandWidth);
    translate([-dockBaseWidth + dockThickness, 0, dockBandWidth + dockThickness * 3]) singleStrap(dockBaseWidth);
}

module phoneHook() {
    dockBase(dockBandWidth);
}

singleStrap(dockHeight);
translate([0, dockStrapGap, 0]) singleStrap(dockHeight);
rotate([0, 0, 90]) translate([0, -dockSupportHeight, 0]) singleStrap(dockWidth);

//base
color("orange") {
    rotate([0, 0, 90]) translate([0, -dockBandWidth -dockThickness * 2, 0]) singleStrap(dockWidth, width = dockBaseLipWidth);
    difference() {
        union() {
            translate([0, 0, dockThickness]) dockBase(width=dockWidth);
            //front lip
            rotate([0, 0, 90]) translate([0, -dockBaseFrontLipWidth, dockBaseWidth + dockThickness]) singleStrap(dockWidth, width = dockBaseFrontLipWidth);
        }
        translate([0, 0, dockThickness]) translate([-dockThickness, usbOpeningStart, 0]) usbOpening();
    }
}
//hook
color("brown") {
    translate([dockHeight - dockThickness, 0, dockThickness]) hook();
    translate([dockHeight - dockThickness, dockStrapGap, dockThickness]) hook();
}
//phone support - prevents phone from slipping out of dock from top
color("blue") {
    translate([dockSupportHeight, dockStrapGap / 3, 0]) singleStrap(phoneSupportHeight);
    translate([phoneHeight, dockStrapGap / 3, dockThickness]) phoneHook();
    translate([dockSupportHeight, 2 * dockStrapGap / 3, 0]) singleStrap(phoneSupportHeight);
    translate([phoneHeight, 2 * dockStrapGap / 3, dockThickness]) phoneHook();
}