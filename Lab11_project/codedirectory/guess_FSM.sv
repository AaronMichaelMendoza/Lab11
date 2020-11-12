`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2020 12:09:17 PM
// Design Name: 
// Module Name: guess_FSM
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


module guess_FSM(
    input clk, en, reset,
    input [3:0] b,
    output reg [3:0] y,
    output reg win,
    output reg lose
    );
    localparam[2:0]
        s0 = 3'b001,
        s1 = 3'b010,
        s2 = 3'b011,
        s3 = 3'b100,
        swin = 3'b101,
        slose = 3'b110;
        
    reg [2:0] state, state_next;
    
    always_ff @(posedge (clk), posedge(reset))
        if (reset) begin
            state <= s0;
        end
        else if (en) begin
            state <= state_next;
        end
        
    always_comb begin
        y[3:0]  = 0;
        win = 0;
        lose=0;
        case(state)
            s0: begin
            y=4'b0001;
                if (b[1] | b[2] | b[3]) begin
                    state_next = slose;
                    end
                else if (b[0] & ~b[1] & ~b[2] & ~b[3]) begin
                    state_next = swin;
                    end
                else 
                    state_next = s1;
                end
            s1: begin
            y=4'b0010;
                if (b[0] | b[2] | b[3]) begin
                    state_next = slose;
                    end
                else if (~b[0] & b[1] & ~b[2] & ~b[3]) begin
                    state_next = swin;
                    end    
                else 
                    state_next = s2;
                end
            s2: begin
            y=4'b0100;
                if (b[0] | b[1] | b[3]) begin
                    state_next = slose;
                    end
                else if (~b[0] & ~b[1] & b[2] & ~b[3]) begin
                    state_next = swin;
                    end    
                else 
                    state_next = s3;
                end
            s3: begin
            y=4'b1000;
                if (b[0] | b[1] | b[2]) begin
                    state_next = slose;
                    end
                else if (~b[0] & ~b[1] & ~b[2] & b[3]) begin
                    state_next = swin;
                    end    
                else 
                    state_next = s0;
                end
            slose: begin
            lose = 1; 
            win = 0;
            y = 4'b0110;
                if (b[0] | b[1] | b[2] | b[3]) begin
                    state_next = slose;
                    end
                else 
                    state_next = s0;
                end
            swin: begin
            win= 1;
            lose = 0;
            y=4'b1111;
                if (b[0] | b[1] | b[2] | b[3]) begin
                    state_next = swin;
                    end
                else 
                    state_next = s0;
                end      
          endcase
     end
endmodule
