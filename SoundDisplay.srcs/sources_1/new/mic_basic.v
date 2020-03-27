`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2020 08:07:59 PM
// Design Name: 
// Module Name: mic_basic
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


module mic_basic(
    input CLOCK,
    input [11:0] mic_in,
    input sw,
    output reg [15:0] led,
    output reg [3:0] an,
    output reg [6:0] seg,
    output reg [3:0] volume
    );
    
  reg [11:0]max=12'd0;
  reg [13:0]num=14'd0;
  reg [12:0]count1=12'b0;
  reg [17:0]count2=18'b0;
  reg next=0;
  reg [11:0]current_max=12'd0;
 // reg [3:0]volume;

  //assign vol = volume;

  parameter lower_bound = 2048;
  parameter difference_seg = 146;

  always @ (posedge CLOCK) begin  
    count1 <= count1 + 1;
    count2 <= count2 + 1;
    if (count1[12:0]==13'b1001110001000) begin
      if ( mic_in > max) max <= mic_in;
      num<=num+1;
      count1 <= 0;
      if ( num == 14'd2500) begin
        current_max <= (sw)? max:current_max;
        num <= 0;
        max <= 0;   
      end
    end

    if ( current_max >= lower_bound + 14*difference_seg ) begin
      led <= 16'b1111111111111111;
      volume <= 4'd15;
      if (count2[17:0]==0) 
        case(next)
          1'b0: 
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 1'b1;
            end
          1'b1:
            begin
              an <= 4'b1110;
              seg <= 7'b0010010;
              next <= 1'b0;
            end
        endcase
    end
    else if ( current_max >= lower_bound + 13*difference_seg) begin
      led <= 16'b0111111111111111;
      volume <= 4'd14;
      if (count2[17:0]==0)
        case(next)
          1'b0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 1'b1;
            end
          1'b1:
            begin
              an <= 4'b1110;
              seg <= 7'b0011001;
              next <= 1'b0;
            end
        endcase
    end
    else if ( current_max >= lower_bound + 12*difference_seg) begin
      led <= 16'b0011111111111111;
      volume <= 4'd13;
      if (count2[17:0]==0)
        case(next)
          1'b0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 1'b1;
            end
          1'b1:
            begin
              an <= 4'b1110;
              seg <= 7'b0110000;
              next <= 1'b0;
            end
        endcase
    end
    else if ( current_max >= lower_bound + 11*difference_seg) begin
      led <= 16'b0001111111111111;
      volume <= 4'd12;
      if (count2[17:0]==0)
        case(next)
          1'b0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 1'b1;
            end
          1'b1:
            begin
              an <= 4'b1110;
              seg <= 7'b0100100;
              next <= 1'b0;
            end
        endcase
    end
    else if ( current_max >= lower_bound + 10*difference_seg) begin
      led <= 16'b0000111111111111;
      volume <= 4'd11;
      if (count2[17:0]==0)
        case(next)
          1'b0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 1'b1;
            end
          1'b1:
            begin
              an <= 4'b1110;
              seg <= 7'b1111001;
              next <= 1'b0;
            end
        endcase
    end  
    else if ( current_max >= lower_bound + 9*difference_seg) begin
      led <= 16'b0000011111111111;
      volume <= 4'd10;
      if (count2[17:0]==0)
        case(next)
          1'b0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 1'b1;
            end
          1'b1:
            begin
              an <= 4'b1110;
              seg <= 7'b1000000;
              next <= 1'b0;
            end
        endcase
    end
    else if ( current_max >= lower_bound + 8*difference_seg) begin
      led <= 16'b0000001111111111;
      volume <= 4'd9;
      an <= 4'b1110;
      seg <= 7'b0010000;
    end
    else if ( current_max >= lower_bound + 7*difference_seg) begin
      led <= 16'b0000000111111111;
      volume <= 4'd8;
      an <= 4'b1110;
      seg <= 7'b0000000;
    end
    else if ( current_max >= lower_bound + 6*difference_seg) begin
      led <= 16'b0000000011111111;
      volume <= 4'd7;
      an <= 4'b1110;
      seg <= 7'b1111000;
    end
    else if ( current_max >= lower_bound + 5*difference_seg) begin
      led <= 16'b0000000001111111;
      volume <= 4'd6;
      an <= 4'b1110;
      seg <= 7'b0000010;
    end
    else if ( current_max >= lower_bound + 4*difference_seg) begin
      led <= 16'b0000000000111111;
      volume <= 4'd5;
      an <= 4'b1110;
      seg <= 7'b0010010;
    end     
    else if ( current_max >= lower_bound + 3*difference_seg) begin
      led <= 16'b0000000000011111;
      volume <= 4'd4;
      an <= 4'b1110;
      seg <= 7'b0011001;
    end  
    else if ( current_max >= lower_bound + 2*difference_seg) begin
      led <= 16'b0000000000001111;
      volume <= 4'd3;
      an <= 4'b1110;
      seg <= 7'b0110000;
    end                                              
    else if ( current_max >= lower_bound + 1*difference_seg) begin
      led <= 16'b0000000000000111;
      volume <= 4'd2;
      an <= 4'b1110;
      seg <= 7'b0100100;
    end             
    else if ( current_max >= lower_bound) begin
      led <= 16'b0000000000000011;
      volume <= 4'd1;
      an <= 4'b1110;
      seg <= 7'b1111001;
    end    
    else begin
      led <= 16'b0000000000000001;
      volume <= 4'd0;
      an <= 4'b1110;
      seg <= 7'b1000000;
    end
  end
endmodule

