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
    wire dp;
    guessing_game #(.B(3), .R(1)) dut(
        .btnU(btnU),
        .btnD(btnD),
        .btnR(btnR),
        .btnL(btnL),
        .clk(clk),
        .btnC(btnC),
        .sw(sw),
        .seg(seg),
        .an(an),
        .dp(dp),
        .led(led));
   
    always begin
       #5 clk = ~clk; 
    end
   
    initial begin 
        clk = 0; btnU=0; btnD=0; btnR=0; btnL=0; btnC=0; sw=15'b000000000000001; #5; //hard difficulty
        btnC = 1; #5; btnC = 0; #165; //reset, running through all four states
        btnR = 1; #20; btnR = 0; #85; //win state for s0
        btnD = 1; #20; btnD = 0; #150; //win state for s1
        btnL = 1; #20; btnL = 0; #165; //win state for s2
        btnU = 1; #20; btnU = 0; #70; //win state for s3
        btnL = 1; #20; btnL = 0; #85; //lose state for s0
        btnL = 1; #20; btnL = 0; #170; //lose state for s1
        btnU = 1; #20; btnU = 0; #185; //lose state for s2
        btnL = 1; #20; btnL = 0; #55; //lose state for s3
        btnC = 1; #10; btnC = 0; #55; //test reset
        $finish;
    end
   
endmodule
