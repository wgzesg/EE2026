`timescale 1ns / 1ps

module flowMode(slowClock, pixel_index, pixel_data, currentVolume,
             bgColor, borderColor, volumeBarLowColor, volumeBarMidColor, volumeBarHighColor,
             borderSelct, isBar, isBorder);
             
    localparam Width = 96;
    localparam Height = 64;
    localparam PixelCount = Width * Height;
    localparam PixelCountWidth = $clog2(PixelCount);
    
    input slowClock;
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
    reg [PixelCountWidth - 1:0] x_loc, y_loc;
    reg [4:0] yempty, xempty;
    reg [3:0] historyVolume [0:9];
    integer i;
    initial begin
        for(i = 9; i >= 0; i = i - 1)begin
                historyVolume[i] = 0;
        end
    end 
    
    always @ (posedge slowClock)begin
        for(i = 9; i >= 0; i = i - 1)begin
            historyVolume[i] <= historyVolume[i-1];
        end
        historyVolume[0] <= currentVolume;
    end
    
    always @(pixel_index)begin
        
        x_loc = pixel_index % Width;
        y_loc = pixel_index / Width;
        upperLimit = 53 - historyVolume[(x_loc -3) / 9] * 3;
        yempty = (y_loc - 5) % 3;
        xempty = (x_loc - 3) % 9;
        // Locate where the current pixel is and apply color accordingly
        if(isBar && y_loc > upperLimit && xempty != 0 && yempty != 0 && x_loc > 2 && x_loc < 93 && y_loc > 8 && y_loc < 24)
            pixel_data = volumeBarHighColor;
        else if(isBar && y_loc > upperLimit && xempty != 0 && yempty != 0 && x_loc > 2 && x_loc < 93 && y_loc > 23 && y_loc < 39)
            pixel_data = volumeBarMidColor;
        else if(isBar && y_loc > upperLimit && xempty != 0 && yempty != 0 && x_loc > 2 && x_loc < 93 && y_loc > 38 && y_loc < 57)
            pixel_data = volumeBarLowColor;
        else if(isBorder && (x_loc < borderWidth || y_loc < borderWidth || x_loc > 95- borderWidth || y_loc > 63- borderWidth))
            pixel_data = borderColor;
        else
            pixel_data = bgColor;
    end
endmodule
