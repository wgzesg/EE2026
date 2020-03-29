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
    input reset,
    output reg [15:0] color,
    input [12:0] current,
    input [12:0] framebegin,
    input [3:0] volume,
    output reg [1:0] gameState
    );
    
    (*ram_style = "block"*)reg [15:0] startPage[0: 12287];
    (*ram_style = "block"*)reg [15:0] backgroundMap[0: 6143];
    (*ram_style = "block"*)reg [15:0] characterMap[0: 6143];
    (*ram_style = "block"*)reg [15:0] obstacleMap[0: 6143];
    
    localparam START = 2'b00;
    localparam INGAME = 2'b01;
    localparam DEATH = 2'b11;
    
    localparam WALKING = 0;
    localparam JUMP = 1;
    
    localparam CH_LEFT = 2'b00;
    localparam CH_RIGHT = 2'b01;
    localparam CH_UP = 2'b11;
    localparam CH_DOWN = 2'b00;
    
    localparam OB_UP = 2'b11;
    localparam OB_DOWN = 2'b00;
    
    integer OB_LEFT = 2'b00;
    integer OB_RIGHT = 2'b01;
    
    localparam speed = 3;
    
    initial begin
        $readmemb("startingPage.mem", startPage);
        $readmemh("bitmap.mem", bitmap);
        gameState = START;
    end
    
    reg characterState = 0;
    reg [2:0] i;
    integer x_loc, y_loc;
    integer location = 0;
    
    // control the state changes
    always @(volume)begin
        if(gameState == START && volume > 13)begin
            gameState = INGAME;
        end
        else if(gameState == INGAME && volume > 13)begin
            characterState = JUMP;
        end
    end
    
    // control repetitions of each page 
    always @ (posedge framebegin)begin
        i = i + 1;
        if(i % 4 == 0)
            location = (location + speed) % 96;
    end
    
    // control the pixel output based on region
    always @(current)begin
        if(reset)begin
            gameState = START;
            characterState = 0;
            
        end
        x_loc = current % 96;
        y_loc = current / 96;
        if(gameState == START)begin
            color = startPage[y_loc * 96 + (x_loc + location) % 96];
        end
        else if(gameState == INGAME)begin
            if(x_loc < CH_RIGHT && x_loc > CH_LEFT && y_loc < CH_DOWN && y_loc > CH_UP)
                color = characterMap[current];
            if(x_loc < OB_RIGHT && x_loc > OB_LEFT && y_loc < OB_DOWN && y_loc > OB_UP)
                color = obstacleMap[current];
            else
                color = backgroundMap[y_loc * 96 + (x_loc + location) % 96];
        end
    end
endmodule