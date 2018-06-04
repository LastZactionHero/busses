`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2018 02:41:12 PM
// Design Name: 
// Module Name: debouncer_tb
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


module debouncer_tb(

    );
    
    reg clk;
    reg sw;
    reg n_rst;
    wire q;
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    debouncer #(6) DUT(clk, n_rst, sw, q);
    
    initial begin
        sw = 0;
        n_rst = 0;
        #20;
        
        n_rst = 1;
        #20;
        
        sw = 1;
        #180;
        sw = 0;
        #120;
        
        #200;

        sw = 1;
        #180;
        sw = 0;
        #30;
        sw = 1;
        #180;
        sw = 0;
        #200;
        #200;
        
        $finish;
    end
endmodule
