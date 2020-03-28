`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 01:45:20 PM
// Design Name: 
// Module Name: bitMap
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bitMap(
    output reg [15:0] color,
    input [12:0] current,
    input [12:0] framebegin
    );
    (*ram_style = "block"*)reg [15:0] bitmap[0: 6143];
    reg [14:0] pointer = 0; 
    
    always @(framebegin)begin
        $readmemh("bitmap.mem", bitmap);
    end
    
    always @(current)begin  
        color <= bitmap[current];
    end
endmodule