`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2018 09:07:25 PM
// Design Name: 
// Module Name: register
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


module register(
    input clk,
    input n_rst,
    input load,
    input [3:0] data,
    output reg [3:0] q
    );
    
    always @(posedge clk)
    begin
        if(!n_rst)
            q = 0;
        else if(load)
            q = data;
        else
            q = q;
    end
endmodule
