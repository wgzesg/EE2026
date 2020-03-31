`timescale 1ns / 1ps

module themeManager(
    input clk,
    input [1:0] theme,
    output reg [15:0] borderColor, bgColor, lowrColor, midColor, highColor
    );
    localparam Black = 16'h0000;
    localparam White = 16'hFFFF;
    localparam Green = 16'h07E0;
    localparam Red = 16'hF800;
    localparam Yellow = 16'hFFE0;
    
    //Chagall theme
    localparam t1border = 16'h0000;
    localparam t1bg = 16'b00111_011011_01110;
    localparam t1low = 16'b01101_101101_11001;
    localparam t1mid = 16'b11110_110011_01001;
    localparam t1high = 16'b11000_010110_01000;
    
    //Van Gogh theme
    localparam t2border = 16'b11001_110001_01110;
    localparam t2bg = 16'b00011_001101_00110;
    localparam t2low = 16'b01100_110000_11101;
    localparam t2mid = 16'b01100_100000_11001;
    localparam t2high = 16'b00101_010100_01110;
    
    always @ (posedge clk) begin
        case(theme)
            2'b01:begin  // Chagall theme
                borderColor = t1border;
                bgColor = t1bg;
                lowrColor = t1low;
                midColor = t1mid;
                highColor = t1high;
            end
            2'b10:begin  // Van Gogh theme
                borderColor = t2border;
                bgColor = t2bg;
                lowrColor = t2low;
                midColor = t2mid;
                highColor = t2high;
            end
            default: begin // Default
                borderColor = White;
                bgColor = Black;
                lowrColor = Green;
                midColor = Yellow;
                highColor = Red;
            end
        endcase
                
    end
endmodule
