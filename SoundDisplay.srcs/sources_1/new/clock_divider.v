`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 04:36:26 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input clk_in,
    output reg clk_out=0
    );
    
    reg [11:0] count=0;
    
    always @ ( posedge clk_in )
    begin
        count <= (count [11:0] == 12'b100111000100) ? 0: count+1;
        clk_out <= (count [11:0] == 12'b100111000100) ? ~clk_out: clk_out;
    end
endmodule
