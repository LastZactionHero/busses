`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2018 03:31:22 PM
// Design Name: 
// Module Name: busloader_tb
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


module busloader_tb(

    );
    
    reg clk;
    reg [3:0] sw;
    reg [3:0] btn;
    wire [3:0] led;
    
    busloader #(.hold_threshold(1)) DUT(
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
        sw = 0;
        btn = 4'b1001;
        #55;
        btn = 0;
        #80;

        btn = 0;
        #80;
        
        sw = 4'b1010;
        btn = 4'b0010;
        #80;
        btn = 0;
        #80;

        // Change to display mode
        btn = 4'b0001;
        #40;
        btn = 0;
        #80;
        
        // Display register 1
        sw = 0;
        btn = 4'b0010;
        #40;
        btn = 0;
        #400;

        $finish;
    end

endmodule
