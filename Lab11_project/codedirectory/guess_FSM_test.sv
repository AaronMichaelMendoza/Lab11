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
        clk=0; reset=0; en=0; ; b=4'b0000; #5;
        reset=1; #10;
        reset=0; #5;
        en=1; #75; //two cycles through the states
        en=0; #20; //testing hold
        en=1; #41; //goes into first state
        b=4'b1110; #15; //win state for first state
        b=4'b0000; #15; //let go of button, goes back to first state and enters second state
        b=4'b1101; #15; //win state for second state
        b=4'b0000; #25; 
        b=4'b1011; #15; //win state for third state
        b=4'b0000; #35;
        b=4'b0111; #15; //win state for fourth state
        b=4'b0000; #10; 
        b=4'b0010; #15; //lose state for first state
        b=4'b0000; #15;
        b=4'b1000; #15; //lose state for second state
        b=4'b0000; #25;
        b=4'b1000; #15; //lose state for third state
        b=4'b0000; #35;
        b=4'b0001; #15; //lose state for fourth state
        b=4'b0000; #17; 
        reset = 1; #5; 
        reset = 0; #20; //testing reset
        $finish;
    end    
endmodule
