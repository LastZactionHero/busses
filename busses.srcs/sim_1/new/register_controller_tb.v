`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2018 09:08:14 AM
// Design Name: 
// Module Name: register_controller_tb
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


module register_controller_tb(
    );
    reg clk;
    reg n_rst;
    reg [1:0] mode;
    reg [2:0] func;
    wire [2:0] r_in;
    wire [2:0] r_out;
    wire d_in;
    
    register_controller DUT(clk, n_rst, mode, func, r_in, r_out, d_in);

    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
    
    initial begin
        n_rst = 0;
        repeat(4) #10 clk = ~clk;
        n_rst = 1;
        repeat(4) #10 clk = ~clk;
        
        #5;
        
        // Load
        mode = 2'b00;
        func = 0;
        #40;

        func = 3'b001;
        #20
        func = 0;
        #40;
        
        func = 3'b010;
        #20;
        func = 0;
        #40;

        func = 3'b100;
        #20;
        func = 0;
        #40;
        
        // Display
        mode = 2'b01;
        func = 0;
        #40;
        
        func = 3'b001;
        #20
        func = 0;
        #40;
        
        func = 3'b010;
        #20;
        func = 0;
        #40;

        func = 3'b100;
        #20;
        func = 0;
        #40;
       
        // Swap
//        mode = 2'b10;
//        #20;
        
//        func = 3'b001;
//        #20;
//        func = 0;
//        #60;
        
//        func = 3'b010;
//        #20;
//        func = 0;
//        #60;
        
//        func = 3'b100;
//        #20;
//        func = 0;
//        #60;        

        $finish;
    end    
endmodule
