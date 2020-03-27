`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 09:42:17 AM
// Design Name: 
// Module Name: multiclock
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


module multiclock(
    input CLOCK,
    output clk6p25m, clkbtn, clkFlow
    );
    reg [25:0]counter;
    always @(posedge CLOCK) begin
        counter = counter + 1;
    end
    assign clk6p25m = counter[4];
    assign clkbtn = counter[20];
    assign clkFlow = counter[22];
    
endmodule
