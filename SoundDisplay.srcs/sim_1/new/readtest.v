`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 06:45:25 PM
// Design Name: 
// Module Name: readtest
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


module readtest(

    );
    reg [15:0] bitmap[0: 6143];
    integer i;
    initial
    begin
        #10
        //$readmemh("bitmap.mem", bitmap);
        $readmemb("lowMap.mem", bitmap);
    #10
        for(i = 0; i < 6143; i = i + 1)begin
            $display("%h", bitmap[i]);
        end
    #10    
        $finish;
       
    end
endmodule
