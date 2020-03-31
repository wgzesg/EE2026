`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 10:08:25 AM
// Design Name: 
// Module Name: singlePulse
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


module singlePulse(
    input clkbtn,
    input button,
    output pulse
    );
    reg inter = 0, mediate = 0;
    always @ (posedge clkbtn)begin
        inter <= button;
        mediate <= inter;
    end
    assign pulse = inter & ~mediate;
endmodule
