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

    always @(toggle, n_rst)
    begin
        if(!n_rst || toggle && mode == M_SWAP)
            next_mode = 0;
        else if(toggle)
            next_mode = mode + 1;
        else
            next_mode = next_mode;
    end

    always @(posedge clk)
    begin
        mode = next_mode;
    end
endmodule
