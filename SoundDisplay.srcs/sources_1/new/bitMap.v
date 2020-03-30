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
    localparam PIXEL_PER_FRAME = 6144;
    
    (*ram_style = "block"*)reg [15:0] startPage[0: PIXEL_PER_FRAME * 2 - 1];
    (*ram_style = "block"*)reg [15:0] backgroundMap[0: PIXEL_PER_FRAME - 1];
    (*ram_style = "block"*)reg [15:0] characterMap[0: PIXEL_PER_FRAME * 6 - 1];
    (*ram_style = "block"*)reg [15:0] jumpMap[0: PIXEL_PER_FRAME * 6 - 1];
    (*ram_style = "block"*)reg [15:0] obstacleMap[0: PIXEL_PER_FRAME];
    
    localparam START = 2'b00;
    localparam INGAME = 2'b01;
    localparam DEATH = 2'b11;
    
    localparam WALKING = 0;
    localparam JUMP = 1;
    
    localparam CH_LEFT = 23;
    localparam CH_RIGHT = 35;
    localparam CH_UP = 25;
    localparam CH_DOWN = 54;
    
    localparam OB_UP = 55;
    localparam OB_DOWN = 64;
    
    integer OB_LEFT = 80;
    integer OB_RIGHT = 96;
    
    localparam speed = 3;
    
    initial begin
        $readmemb("startingPage.mem", startPage);
        $readmemb("background.mem", backgroundMap);
        $readmemb("character.mem", characterMap);
        $readmemb("jump.mem", jumpMap);
        $readmemh("obstacle.mem", obstacleMap);
        gameState = START;
    end
    
    reg characterState = 0;
    integer i = 0, jumpCounter = 0;
    integer x_loc, y_loc;
    integer bg_location = 0;
    
    // control the state changes
    always @(volume)begin
        if(gameState == START && volume > 13)begin
            gameState = INGAME;
        end
        else if(gameState == INGAME && volume > 13)begin
            characterState = JUMP;
        end
        else if(gameState == INGAME && jumpCounter == 23)begin
            characterState = WALKING;
        end
        else if(reset)
            gameState = START;
    end
    
    // control repetitions of each page 
    always @ (posedge framebegin)begin
        i = (i == 23)? 0 : i + 1;
        jumpCounter = (characterState == JUMP) ? jumpCounter + 1 : 0;
        if(gameState == INGAME && i % 4 == 0)
            bg_location = (bg_location + speed) % 96;
        else if(reset)
            bg_location = 0;
    end
    
    // control the pixel output based on region
    always @(current)begin
        x_loc = current % 96;
        y_loc = current / 96;
        if(gameState == START)begin
            color = startPage[current + (i / 8) % 2 * PIXEL_PER_FRAME];
        end
        else if(gameState == INGAME)begin
            if(x_loc < CH_RIGHT && x_loc > CH_LEFT && y_loc < CH_DOWN && y_loc > CH_UP && characterState == WALKING)
                color = characterMap[current + i / 4 * PIXEL_PER_FRAME];
            else if(x_loc < CH_RIGHT && x_loc > CH_LEFT && y_loc < CH_DOWN && y_loc > CH_UP && characterState == JUMP)
                color = jumpMap[current + jumpCounter / 8 * PIXEL_PER_FRAME];
            //if(x_loc < OB_RIGHT && x_loc > OB_LEFT && y_loc < OB_DOWN && y_loc > OB_UP)
            //    color = obstacleMap[current];
            else
                color = backgroundMap[y_loc * 96 + (x_loc + bg_location) % 96];
        end
    end
endmodule