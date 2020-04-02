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
    input [3:0]sw,
    output reg [15:0] led,
    output reg [3:0] an,
    output reg [6:0] seg,
    output reg [3:0] volume
    );
    
  reg [11:0]max=12'd0;
  reg [13:0]num=14'd0;
  reg [12:0]count1=12'b0;
  reg [17:0]count2=18'b0;

  reg [1:0] next=0;
  reg [11:0]current_max=12'd0;

  parameter lower_bound = 2116;
  parameter difference_seg = 132;

  always @ (posedge CLOCK) begin  
    count1 <= count1 + 1;
    count2 <= count2 + 1;
    if (count1[12:0]==13'b1001110001000) begin//20kHz
      if ( mic_in > max) max <= mic_in;
      num<=num+1;
      count1 <= 0;
      if ( ((sw[2:1] == 2'b00 || sw[2:1] == 2'b11) && num == 14'd2500) || (sw[2:1] == 2'b01 && num == 14'd5000) || (sw[2:1] == 2'b10 && num == 14'd10000) ) begin//8Hz, 4Hz, 2Hz
        current_max <= (sw[3])? max:current_max;
        num <= 0;
        max <= 0;   
      end
    end

    if ( current_max >= lower_bound + 14*difference_seg ) begin//15
      led <= (sw[0]) ? mic_in: 16'b1111111111111111;
      volume <= 4'd15;
      if (count2[17:0]==0)//381Hz for 7-segment display
        case(next)
          2'd0: 
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b1110;
              seg <= 7'b0010010;
              next <= 2'd2;
            end
          2'd2:
            begin
              an <= 4'b0011;
              seg <= 7'b0110110;
              next <= 2'd0;
            end
        endcase
    end
    else if ( current_max >= lower_bound + 13*difference_seg) begin//14
      led <= (sw[0]) ? mic_in:16'b0111111111111111;
      volume <= 4'd14;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b1110;
              seg <= 7'b0011001;
              next <= 2'd2;
            end
          2'd2:
            begin
              an <= 4'b0011;
              seg <= 7'b0110110;
              next <= 2'd0;
            end               
        endcase
    end
    else if ( current_max >= lower_bound + 12*difference_seg) begin//13
      led <= (sw[0]) ? mic_in:16'b0011111111111111;
      volume <= 4'd13;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b1110;
              seg <= 7'b0110000;
              next <= 2'd2;
            end
          2'd2:
            begin
              an <= 4'b0011;
              seg <= 7'b0110110;
              next <= 2'd0;
            end          
        endcase
    end
    else if ( current_max >= lower_bound + 11*difference_seg) begin//12
      led <= (sw[0]) ? mic_in:16'b0001111111111111;
      volume <= 4'd12;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b1110;
              seg <= 7'b0100100;
              next <= 2'd2;
            end
          2'd2:
            begin
              an <= 4'b0011;
              seg <= 7'b0110110;
              next <= 2'd0;
            end            
        endcase
    end
    else if ( current_max >= lower_bound + 10*difference_seg) begin//11
      led <= (sw[0]) ? mic_in:16'b0000111111111111;
      volume <= 4'd11;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b1110;
              seg <= 7'b1111001;
              next <= 2'd2;
            end
          2'd2:
            begin
              an <= 4'b0011;
              seg <= 7'b0110110;
              next <= 2'd0;
            end  
        endcase
    end  
    else if ( current_max >= lower_bound + 9*difference_seg) begin//10
      led <= (sw[0]) ? mic_in:16'b0000011111111111;
      volume <= 4'd10;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1101;
              seg <= 7'b1111001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b1110;
              seg <= 7'b1000000;
              next <= 2'd2;
            end
          2'd2:
            begin
              an <= 4'b0011;
              seg <= 7'b0110111;
              next <= 2'd0;
            end             
        endcase
    end
    else if ( current_max >= lower_bound + 8*difference_seg) begin//9
      led <= (sw[0]) ? mic_in:16'b0000001111111111;
      volume <= 4'd9;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b0010000;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b0110111;
              next <= 2'd0;
            end             
        endcase
    end
    else if ( current_max >= lower_bound + 7*difference_seg) begin//8
      led <= (sw[0]) ? mic_in:16'b0000000111111111;
      volume <= 4'd8;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b0000000;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b0110111;
              next <= 2'd0;
            end             
        endcase
    end
    else if ( current_max >= lower_bound + 6*difference_seg) begin//7
      led <= (sw[0]) ? mic_in:16'b0000000011111111;
      volume <= 4'd7;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b1111000;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b0110111;
              next <= 2'd0;
            end             
        endcase      
    end
    else if ( current_max >= lower_bound + 5*difference_seg) begin//6
      led <= (sw[0]) ? mic_in:16'b0000000001111111;
      volume <= 4'd6;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b0000010;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b0110111;
              next <= 2'd0;
            end             
        endcase    
    end
    else if ( current_max >= lower_bound + 4*difference_seg) begin//5
      led <= (sw[0]) ? mic_in:16'b0000000000111111;
      volume <= 4'd5;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b0010010;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b0110111;
              next <= 2'd0;
            end             
        endcase      
    end     
    else if ( current_max >= lower_bound + 3*difference_seg) begin//4
      led <= (sw[0]) ? mic_in:16'b0000000000011111;
      volume <= 4'd4;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b0011001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b1110111;
              next <= 2'd0;
            end             
        endcase      
    end  
    else if ( current_max >= lower_bound + 2*difference_seg) begin//3
      led <= (sw[0]) ? mic_in:16'b0000000000001111;
      volume <= 4'd3;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b0110000;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b1110111;
              next <= 2'd0;
            end             
        endcase      
    end                                              
    else if ( current_max >= lower_bound + 1*difference_seg) begin//2
      led <= (sw[0]) ? mic_in:16'b0000000000000111;
      volume <= 4'd2;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b0100100;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b1110111;
              next <= 2'd0;
            end             
        endcase      
    end             
    else if ( current_max >= lower_bound) begin//1
      led <= (sw[0]) ? mic_in:16'b0000000000000011;
      volume <= 4'd1;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b1111001;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b1110111;
              next <= 2'd0;
            end             
        endcase      
    end    
    else begin//0
      led <= (sw[0]) ? mic_in:16'b0000000000000001;
      volume <= 4'd0;
      if (count2[17:0]==0)
        case(next)
          2'd0:
            begin
              an <= 4'b1110;
              seg <= 7'b1000000;
              next <= 2'd1;
            end
          2'd1:
            begin
              an <= 4'b0011;
              seg <= 7'b1110111;
              next <= 2'd0;
            end             
        endcase      
    end
  end
endmodule

