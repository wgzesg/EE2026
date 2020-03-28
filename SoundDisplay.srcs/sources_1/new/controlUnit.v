`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 10:41:27 PM
// Design Name: 
// Module Name: controlUnit
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


module controlUnit(
    input clk,
    input [3:0] volume,
    input leftJumpComplete,
    input rightJumpComplete,
    output reg [1:0] location = 2'b11
    );
    localparam left = 2'b00;
    localparam inair = 2'b01;
    localparam right = 2'b11;
    
    always @(posedge clk, posedge leftJumpComplete, posedge rightJumpComplete)begin
        if(leftJumpComplete)
            location = left;
        else if(rightJumpComplete)
            location = right;
        else if(volume > 12 && location != inair)
            location = inair;
    end
endmodule
