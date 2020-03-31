`timescale 1ns / 1ps

module bitMap(
    input clk,
    input reset,
    output reg [15:0] color,
    input [12:0] current,
    input [12:0] framebegin,
    input [3:0] volume,
    output reg [1:0] gameState
    );
    localparam PIXEL_PER_FRAME = 6144;
    
    reg [15:0] startPage[0: PIXEL_PER_FRAME * 2 - 1];
    reg [15:0] backgroundMap[0: PIXEL_PER_FRAME - 1];
    reg [15:0] characterMap[0: 345 * 6 - 1];
    reg [15:0] jumpMap[0: 450 * 6 - 1];
    (*_style = "block"*)reg [15:0] obstacleMap[0: 960 - 1];
    reg [15:0] deathPage[0: PIXEL_PER_FRAME * 2 - 1];
    
    localparam START = 2'b00;
    localparam INGAME = 2'b01;
    localparam DEATH = 2'b11;
    
    localparam WALKING = 0;
    localparam JUMP = 1;
    
    localparam CH_LEFT = 22;
    localparam CH_RIGHT = 36;
    localparam CH_DOWN = 54;
    localparam CHW_UP = 30;
    localparam CHJ_UP = 23;
    
    localparam OB_UP = 64;
    localparam OB_DOWN = 53;
    
    integer ob_left = 65;
    integer ob_right = 77;
    
    localparam speed = 3;
    
    initial begin
        $readmemb("startingPage.mem", startPage);
        $readmemb("background.mem", backgroundMap);
        $readmemb("character.mem", characterMap);
        $readmemb("jump.mem", jumpMap);
        $readmemb("obstacle.mem", obstacleMap);
        $readmemb("deathPage.mem", deathPage);
        gameState = START;
    end
    
    reg characterState = 0;
    integer i = 0, jumpCounter = 0, walkCounter = 0;
    integer x_loc, y_loc;
    integer bg_location = 0;
    
    // control the state changes
    always @(posedge clk)begin
        if(gameState == START && volume > 8)begin
            gameState = INGAME;
            #10;
        end
        else if(reset)
            gameState = START;
        else if(gameState == INGAME && ob_left < CH_RIGHT - 2 && ob_right > CH_LEFT + 2 && characterState == WALKING)
            gameState = DEATH;
        
        if(characterState == WALKING && gameState == INGAME && volume > 13)
            characterState = JUMP;
        else if(gameState == INGAME && jumpCounter > 47)  
            characterState = WALKING; 
    end
    
    // control repetitions of each page 
    always @ (posedge framebegin)begin
        i = (i + 1) % 16;
        if(gameState == INGAME)begin
            walkCounter = (characterState == WALKING) ? walkCounter + 1 : 0;
            jumpCounter = (characterState == JUMP) ? jumpCounter + 1 : 0;
            if (i % 4 == 0)begin
                bg_location = (bg_location + speed) % 96;
                ob_left = (ob_left + 93) % 96;
                ob_right = (ob_right + 93) % 96;
            end
        end
        else if(gameState == START)begin
            ob_left = 65;
            ob_right = 77;
            bg_location = 0;
        end
    end
    
    // control the pixel output based on region
    always @(current)begin
        x_loc = current % 96;
        y_loc = current / 96;
        if(gameState == START)begin
            color = startPage[current + (i >> 3) % 2 * PIXEL_PER_FRAME];
        end
        
        else if(gameState == INGAME)begin
            // walking 
            if(characterState == WALKING && x_loc < CH_RIGHT && x_loc > CH_LEFT && y_loc < CH_DOWN && y_loc > CHW_UP)
                color = characterMap[x_loc - CH_LEFT - 1 + (y_loc - CHW_UP - 1) * 15 + (walkCounter >> 3) % 6 * 345];
            
            else if(characterState == JUMP && x_loc < CH_RIGHT && x_loc > CH_LEFT && y_loc < CH_DOWN && y_loc > CHJ_UP)
                color = jumpMap[x_loc - CH_LEFT - 1 + (y_loc - CHJ_UP - 1) * 15 + (jumpCounter >> 3) % 6 * 450];
            
            // ground + obstacle
            else if(y_loc > OB_DOWN && y_loc < OB_UP)
                color = obstacleMap[y_loc * 96 + (x_loc + bg_location) % 96 - 5184];
            
            // background
            else
                color = backgroundMap[y_loc * 96 + (x_loc + bg_location) % 96];
        end
        
        else if(gameState == DEATH)begin
            if(y_loc > OB_DOWN && y_loc < OB_UP)
                color = obstacleMap[y_loc * 96 + (x_loc + bg_location) % 96 - 5184];
            else         
                color = deathPage[current + (i >> 3) % 2 * PIXEL_PER_FRAME];
        end
    end
endmodule