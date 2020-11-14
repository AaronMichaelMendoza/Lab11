`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2020 04:26:19 PM
// Design Name: 
// Module Name: guessing_game_test
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


module guessing_game_test();
    reg btnU, btnD, btnR, btnL, clk, btnC;
    reg[15:0] sw;
    wire[6:0] seg;
    wire[3:0] an;
    wire[15:0] led;
    guessing_game dut(
        .btnU(btnU),
        .btnD(btnD),
        .btnR(btnR),
        .btnL(btnL),
        .clk(clk),
        .btnC(btnC),
        .sw(sw),
        .seg(seg),
        .an(an),
        .led(led));
   
    always begin
       #5 clk = ~clk; 
    end
   
    initial begin 
        clk = 0; btnU=0; btnD=0; btnR=0; btnL=0; btnC=0; sw=0; #30;
        btnU = 1; #15;
        $finish;
    end
   
endmodule
