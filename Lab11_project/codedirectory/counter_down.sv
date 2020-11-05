`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2020 11:42:14 AM
// Design Name: 
// Module Name: counter
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


module counter_down #(parameter N=21)(
    input clk,
    input rst,
    output [N-1:N-2] out
    );
    reg [N-1:0] Qreg, Qnext;
    always @(posedge clk, posedge rst) begin
        if (rst) 
        Qreg <= 0;
        else
        Qreg <= Qnext;
    end
    always @* begin
        Qnext = Qreg-1;
        if (Qreg ==0)
            Qreg= N;
    end
    assign out = Qreg;
    
endmodule
