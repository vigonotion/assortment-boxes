include <BOSL2/std.scad>

SegmentSizeX = 49;           // Width of a single segment (1x1)
SegmentSizeY = SegmentSizeX; // Depth of a single segment (1x1)
GridSegmentsX = 3;           // Grid: Numbers of segmetns in X axis (width)
GridSegmentsY = 4;           // Grid: Numbers of segmetns in Y axis (depth)
BoxSegmentsX = 2;            // Box: Width of the box (Number of segments)
BoxSegmentsY = 2;            // Box: Depth of the box (Number of segments)

// Box: Height of the box. (My default: 1 => 25 / 2 => 46.6)
BoxHeight = BoxHeightUnits * BoxHeightBase -
            (BoxHeightUnits - 1) * (GridHeight + StackOverlap + BoxWallThickness / 4 + BoxTolerance);

BoxWallThickness = 1.6; // Box: Thickness of the wall (a multiple of your nozzle diameter is rec;ended)
BoxTolerance = 0.2;     // Box: Tolerance that the boxes can be stacked easier
StackOverlap = 1.4;     // Box: This is only the straight part
GridHeight = 1.6;       //
GridTolerance = 0.2;    //
BoxHeightBase = 25;     // Box: Base height (the smalles height of boxes you want)
BoxHeightUnits =
    2; // Box: How many units high should the box be. It's NOT a multiple of the base height because of the overlap.
LipTop = (GridHeight + StackOverlap + BoxWallThickness / 4 + BoxTolerance) + 0.4; // Lip: Distance from top
LipWidth = SegmentSizeX - 2 * BoxWallThickness;                                   //
LipHeight = 15;                                                                   //
LipStickerWidth = 13;

radius = 2 * BoxWallThickness; //
nothing = 0.01;

module Cutout()
{

    // down(GridHeight/2)
    translate([ radius, radius, 0 ])
    {
        union()
        {
            prismoid(SegmentSizeY - 4 * BoxWallThickness, SegmentSizeY - 2 * BoxWallThickness, GridHeight,
                     rounding2 = radius, anchor = BOTTOM + LEFT + FRONT);

            // down(1) cuboid([ SegmentSizeY - 4 * BoxWallThickness, SegmentSizeY - 4 * BoxWallThickness, 1 ],
            //                anchor = BOTTOM + LEFT + FRONT);

            // translate([ -radius / 2, -radius / 2, GridHeight ])
            //     prismoid(SegmentSizeY - 2 * BoxWallThickness, SegmentSizeY - 2 * BoxWallThickness, 10,
            //              rounding = radius, anchor = BOTTOM + LEFT + FRONT);
        }
    }
}

module Grid()
{

    // square(SegmentSizeY); // todo radius

    difference()
    {
        cube([ SegmentSizeX * GridSegmentsX, SegmentSizeY * GridSegmentsY, GridHeight ]);

        for (i = [0:GridSegmentsX - 1])
        {
            for (j = [0:GridSegmentsY - 1])
            {
                translate([ i * SegmentSizeX, j * SegmentSizeY, 0 ]) scale([1, 1, 1+2*nothing]) down(nothing)  Cutout();
            }
        }
    }
}

Grid();