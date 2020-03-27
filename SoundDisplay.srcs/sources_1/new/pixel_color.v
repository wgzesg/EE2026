`timescale 1ns / 1ps

module pixel_color(pixel_index, pixel_data, currentVolume,
             bgColor, borderColor, volumeBarLowColor, volumeBarMidColor, volumeBarHighColor,
             borderSelct, isBar, isBorder);
             
    localparam Width = 96;
    localparam Height = 64;
    localparam PixelCount = Width * Height;
    localparam PixelCountWidth = $clog2(PixelCount);

    input [3:0] currentVolume;
    input [PixelCountWidth-1:0] pixel_index;
    output reg [15:0] pixel_data;
    input [15:0] bgColor, borderColor, volumeBarLowColor, volumeBarMidColor, volumeBarHighColor;
    input borderSelct;
    input isBar;
    input isBorder;
    wire [PixelCountWidth-1:0] borderWidth;
    assign borderWidth = (borderSelct) ? 3 : 1;
    reg [PixelCountWidth - 1:0] upperLimit;
    reg [PixelCountWidth - 1:0] x_loc, y_loc, empty;
    
    always @(pixel_index)begin
        x_loc = pixel_index % Width;
        y_loc = pixel_index / Width;
        upperLimit = 53 - currentVolume * 3;
        empty = (y_loc - 5) % 3;
        // Locate where the current pixel is and apply color accordingly
        if(isBar && y_loc > upperLimit && empty != 0 &&x_loc > 44 && x_loc < 53 && y_loc > 8 && y_loc < 24)
            pixel_data = volumeBarHighColor;
        else if(isBar && y_loc > upperLimit && empty != 0 && x_loc > 44 && x_loc < 53 && y_loc > 23 && y_loc < 39)
            pixel_data = volumeBarMidColor;
        else if(isBar && y_loc > upperLimit && empty != 0 && x_loc > 44 && x_loc < 53 && y_loc > 38 && y_loc < 57)
            pixel_data = volumeBarLowColor;
        else if(isBorder && (x_loc < borderWidth || y_loc < borderWidth || x_loc > 95- borderWidth || y_loc > 63- borderWidth))
            pixel_data = borderColor;
        else
            pixel_data = bgColor;
    end
endmodule
