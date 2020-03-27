`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
  input CLOCK,
  input J_MIC3_Pin3,
  output J_MIC3_Pin1,
  output J_MIC3_Pin4,
  output [7:0] JB,
  output [15:0] led,
  output [3:0] an,
  output [6:0] seg,
  input button,
  input [15:0] sw
);
  wire clk6p25m, clkbtn, clk20k, clkFlow;
  wire reset;
  wire [12:0] frame_begin, sending_pixels, sample_pixel, pixel_index;
  wire [4:0] teststate;
  wire [15:0] Oled_in;
  wire [11:0] mic_in;
  wire [3:0]vol;
  wire [15:0] FlowData, staticData;

  wire [15:0] borderColor, bgColor, lowColor, midColor, highColor;
  wire [15:0] pixel_data;
  assign Oled_in = {5'b00000, mic_in[11:6], 5'b00000};
  assign pixel_data = (sw[10])? FlowData: staticData;

  multiclock timerUnit(CLOCK, clk6p25m, clkbtn, clkFlow);    // timer unit for the entire project
  singlePulse(clk6p25m, button, reset);                // singlePulse DFF unit

  clock_divider (CLOCK, clk20k);
  Audio_Capture audio( CLOCK, clk20k, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in); 
  mic_basic ledoutput( CLOCK, mic_in, sw[0], led, an, seg, vol);

  themeManager theme(clk6p25m, sw[15:14], borderColor, bgColor, lowColor, midColor, highColor);

  flowMode trial(clkFlow, pixel_index, FlowData, vol,
                 bgColor, borderColor, lowColor, midColor, highColor,
                 sw[13], ~sw[11], ~sw[12]);
  pixel_color static(pixel_index, staticData, vol,
                     bgColor, borderColor, lowColor, midColor, highColor,
                     sw[13], ~sw[11], ~sw[12]);
  Oled_Display Oled_Display(clk6p25m, reset, frame_begin, sending_pixels,
                            sample_pixel, pixel_index, pixel_data, JB[0], JB[1], JB[3], JB[4], JB[5], JB[6],
                            JB[7],teststate);
  //bitMap mapping(pixel_data, pixel_index, frame_begin);
  
  endmodule
