`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2018 09:08:00 PM
// Design Name: 
// Module Name: register_tb
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


module register_tb(
    );
    reg clk;
    reg n_rst;
    reg load;
    reg r_out;
    reg [3:0]data;
    wire [3:0] q;
    
    register DUT(clk, n_rst, load, r_out, data, q);
    
    initial begin
        clk = 0;
        n_rst = 0;
        repeat(4) #10 clk = ~clk;
        n_rst = 1;
        forever #10 clk = ~clk; 
    end
    
    initial begin
        r_out = 1;
        data = 4'b1010;
        #40;
        load = 1;
        #40;
        
        data = 4'b0101;
        #40;
        load = 1;
        #40;
        
        r_out = 0;
        #40;
    end
    
endmodule
