`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 11:05:04 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk,
    input n_rst,
    output reg c
    );
    parameter n = 50_000_000;    
    reg [31:0]counter;
    
    always @(posedge clk) begin
        if (n_rst == 0) begin
            counter = 0;
            c = 0;
        end
        else if(counter == (n - 1)) begin
            counter = 0;
            c = 1;
        end
        else begin
            counter = counter + 1;
            c = 0;
        end
    end
endmodule
