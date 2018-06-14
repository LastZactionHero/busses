`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2018 03:10:42 AM
// Design Name: 
// Module Name: mode
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


module mode_set(
    input clk,
    input n_rst,
    input toggle,
    output reg [1:0]mode
    );
    parameter [1:0] M_STORE = 2'b00, M_DISPLAY = 2'b01, M_SWAP = 2'b10;
    reg [1:0]next_mode;

    always @(posedge toggle)
    begin
        case(mode)
        M_STORE: next_mode = M_DISPLAY;
        M_DISPLAY: next_mode = M_SWAP;
        M_SWAP: next_mode = M_STORE;
        endcase
    end

    always @(posedge clk, posedge n_rst)
    begin
        if(!n_rst) begin
            mode = M_STORE;
//            next_mode = M_STORE;
        end
        else
            mode = next_mode;
    end
endmodule
