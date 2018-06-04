`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2018 04:46:44 AM
// Design Name: 
// Module Name: mode_tb
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


module mode_set_tb(

    );
    
    reg clk;
    reg n_rst;
    reg toggle;
    wire [1:0]mode;
    
    mode_set DUT(clk, n_rst, toggle, mode);
    
    initial begin
        clk = 0;
        forever #20 clk = ~clk;
    end
    
    integer i;
    
    initial begin
        toggle = 0;
        n_rst = 0;
        #30;
        n_rst = 1;
        #40;

        for(i = 0; i < 5; i = i + 1)
        begin
            toggle = 1;
            #20;
            toggle = 0;
            #40;
        end
        
        $finish;
    end
endmodule
