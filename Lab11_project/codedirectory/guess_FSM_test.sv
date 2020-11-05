`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2020 01:06:56 PM
// Design Name: 
// Module Name: guess_FSM_test
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


module guess_FSM_test();
    reg clk, en, reset;
    reg [3:0] b;
    wire [3:0] y;
    wire win;
    wire lose;
    guess_FSM dut(
        .clk(clk),
        .en(en),
        .reset(reset),
        .b(b),
        .y(y),
        .win(win),
        .lose(lose));
    always begin 
        #5 clk = ~clk;
    end
    
    initial begin
        clk=0; reset=0; in=0; #5;
        reset=1; #10;
        reset=0; #5;
        
endmodule
