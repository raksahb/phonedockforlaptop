phoneFrontCameraAreaHeight = 15;
phoneWidth = 80;
phoneHeight = 155;
dockThickness = 1.5;
dockHeight = phoneHeight - phoneFrontCameraAreaHeight;
dockBandWidth = 5;
dockWidth = phoneWidth + (2 * dockBandWidth);
dockBaseLipWidth = dockBandWidth * 1.5;
dockBaseWidth = 2 * dockBandWidth;
usbOpeningWidth = 30;
usbOpeningStart = (dockWidth - usbOpeningWidth) / 2;
dockStrapGap = phoneWidth + dockBandWidth;
dockSupportHeight = 110;

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


singleStrap(dockHeight);
translate([0, dockStrapGap, 0]) singleStrap(dockHeight);
rotate([0, 0, 90]) translate([0, -dockSupportHeight, 0]) singleStrap(dockWidth);

//base
rotate([0, 0, 90]) translate([0, -dockBandWidth, 0]) singleStrap(dockWidth);
difference() {
    
union() {
translate([0, 0, dockThickness]) dockBase(width=dockWidth);
rotate([0, 0, 90]) translate([0, -dockBaseLipWidth, dockBaseWidth + dockThickness]) singleStrap(dockWidth, width = dockBaseLipWidth);
}
    translate([0, 0, dockThickness]) translate([-dockThickness, usbOpeningStart, 0]) usbOpening();
}
//hook
translate([dockHeight - dockThickness, 0, dockThickness]) dockBase(dockBandWidth);
translate([dockHeight - dockThickness, dockStrapGap, dockThickness]) dockBase(dockBandWidth);
translate([dockHeight-dockBandWidth*2, 0, dockBaseWidth + dockThickness]) singleStrap(dockBaseWidth);
translate([dockHeight-dockBandWidth*2, dockStrapGap, dockBaseWidth]) singleStrap(dockBaseWidth);


