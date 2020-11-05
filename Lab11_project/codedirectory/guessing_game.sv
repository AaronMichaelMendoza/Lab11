`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2020 01:15:32 PM
// Design Name: 
// Module Name: guessing_game
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


module guessing_game(
    input btnU, btnD, btnR, btnL, clk, btnC, sw[0],
    output [6:0] seg,
    output [3:0] an,
    output [15:0] led
    );
    
    wire[3:0] db_out, dc;
    wire easy_out, hard_out, mux_out;
    
    debounce db1 (
        .clk(clk),
        .reset(btnC),
        .in(btnU),
        .out(dc[0]),
        .tick(db_out[0]));
    debounce db2 (
        .clk(clk),
        .reset(btnC),
        .in(btnD),
        .out(dc[1]),
        .tick(db_out[1]));
    debounce db3 (
        .clk(clk),
        .reset(btnC),
        .in(btnR),
        .out(dc[2]),
        .tick(db_out[2]));
    debounce db4 (
        .clk(clk),
        .reset(btnC),
        .in(btnL),
        .out(dc[3]),
        .tick(db_out[3]));
        
        counter_down easy(
            .clk(clk),
            .rst(btnC),
            .out(easy_out));
            
        counter_down #(.N(11)) hard(
            .clk(clk),
            .rst(btnC),
            .out(hard_out));
            
        mux_diff mymux(
            .in0(easy_out),
            .in1(hard_out),
            .sel(sw[0]),
            .out(mux_out));
    
    guess_FSM myguess_FSM(
        .b(db_out),
        .clk(clk),
        .en(mux_out),
        .y(an),
        .win(led[15:8]),
        .lose(led[7:0]));
    
    assign seg[6:0] = 7'b0000001; 

endmodule
