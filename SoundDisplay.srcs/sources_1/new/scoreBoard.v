`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 11:16:17 PM
// Design Name: 
// Module Name: scoreBoard
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


module scoreBoard(
    input reset,
    input sw,
    output reg [3:0] anode = 4'b1110,
    output reg [6:0] seg,
    input clk_1s, flashing,
    input [1:0] gameState
    );
    reg [8:0] score = 0;
    reg [3:0] counter1, counter2, counter3, counter4, currentCounter;
    
    always @(posedge clk_1s)begin
        if(sw && gameState == 2'b01)
            score = score + 1;
        else
            score = 0;
        counter1 = score % 10;
        counter2 = (score / 10) % 10;
        counter3 = (score / 100) % 10;
        counter4 = (score / 1000) % 10;
    end
    
    always @(posedge flashing)begin
        case(anode)
            4'b1011: begin
                        anode = 4'b1101;
                        currentCounter = counter2;
                     end
            4'b1101: begin
                        anode = 4'b1110;
                        currentCounter = counter1;
                     end
            4'b1110: begin
                        anode = 4'b0111;
                        currentCounter = counter4;
                     end
            4'b0111: begin
                        anode = 4'b1011;
                        currentCounter = counter3;
                     end      
        endcase
        case(currentCounter)
            0: seg = 7'b1000000;
            1: seg = 7'b1111001;
            2: seg = 7'b0100100;
            3: seg = 7'b0110000;
            4: seg = 7'b0011001;
            5: seg = 7'b0010010;
            6: seg = 7'b0000010;
            7: seg = 7'b1111000;
            8: seg = 7'b0000000;
            9: seg = 7'b0010000;        
        endcase
    end
endmodule