`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2018 11:55:20 PM
// Design Name: 
// Module Name: register_loader_tb
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


module register_loader_tb(

    );
    
    reg clk;
    reg [3:0] sw;
    reg [3:0] btn;
    wire [3:0] led;
    
    register_loader #(.hold_threshold(1)) DUT(
        .CLK100MHZ(clk),
        .sw(sw),
        .btn(btn),
        .led(led)
    );
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    initial begin
        sw = 4'b0101;
        btn = 4'b1001;
        #55;
        btn = 0;
        #80;
        
        btn = 4'b0001;
        #40;
        btn = 4'b0000;
        #100;
        
        btn = 4'b0010;
        #40;
        btn = 4'b0000;
        #100;

        btn = 4'b0010;
        #40;
        btn = 4'b0000;
        #100;
        
        $finish;
    end
endmodule
