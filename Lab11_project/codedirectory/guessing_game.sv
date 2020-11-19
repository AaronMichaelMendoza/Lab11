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


module guessing_game #(parameter B = 27, R = 21)( 
    input btnU, btnD, btnR, btnL, clk, btnC,
    input[15:0] sw,
    output reg [6:0] seg,
    output [3:0] an,
    output reg [15:0] led,
    output dp
    );
    
    wire[3:0] db_out, dc;
    wire easy_out, hard_out, mux_out; 
    reg win_out, lose_out;
    reg[3:0] y_out;
    
    debounce #(.N(R)) db1 (
        .clk(clk),
        .reset(btnC),
        .in(btnR),
        .out(dc[0]),
        .tick(db_out[0]));
    debounce #(.N(R)) db2 (
        .clk(clk),
        .reset(btnC),
        .in(btnD),
        .out(dc[1]),
        .tick(db_out[1]));
    debounce #(.N(R)) db3 (
        .clk(clk),
        .reset(btnC),
        .in(btnL),
        .out(dc[2]),
        .tick(db_out[2]));
    debounce #(.N(R)) db4 (
        .clk(clk),
        .reset(btnC),
        .in(btnU),
        .out(dc[3]),
        .tick(db_out[3]));
        
        counter #(.N(B)) easy(
            .clk(clk),
            .rst(btnC),
            .out(easy_out));
            
        counter #(.N(B-1)) hard(
            .clk(clk),
            .rst(btnC),
            .out(hard_out));
            
        mux_diff mymux(
            .in0(easy_out),
            .in1(hard_out),
            .sel(sw[0]),
            .out(mux_out));
    
    guess_FSM myguess_FSM(
        .b(dc),
        .clk(clk),
        .en(mux_out),
        .reset(btnC),
        .y(y_out),
        .win(win_out),
        .lose(lose_out));
    
    always @* begin
        case(y_out)
            4'b0001: seg = 7'b1111101;
            4'b0010: seg = 7'b0111111;
            4'b0100: seg = 7'b1011111;
            4'b1000: seg = 7'b1111110;
            default: seg = 7'b1111111;
        endcase
    end
    
    always @* begin
    if (win_out)
        led = 16'b1111111111111111;
    else if (lose_out)
        led = 16'b1010101010101010;
    else 
        led = 16'b0000000000000000;  
    end
        
    assign an = 4'b1110;
    assign dp=1'b1;   

endmodule
