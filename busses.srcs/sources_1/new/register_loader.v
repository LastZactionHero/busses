`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2018 11:44:40 PM
// Design Name: 
// Module Name: register_loader
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


module register_loader(
    input CLK100MHZ,
    input [3:0] btn,
    input [3:0] sw,
    output [3:0] led
    );
    parameter hold_threshold = 50_000_000;

    wire n_rst = ~(btn[0] && btn[3]);
    wire btn_store;
    wire btn_display;
    
    reg state_display;

    // Press button 0: save switches to register
    // Press button 1: toggle show on LEDs
    
    // Button Debouncers
    debounce #(.n(hold_threshold)) DB0 (
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .btn(btn[0]),
        .trig(btn_store)
    );
    
    debounce #(.n(hold_threshold)) DB1 (
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .btn(btn[1]),
        .trig(btn_display)
    );
    
    always @(posedge btn_display, negedge n_rst) begin
        if(!n_rst)
            state_display = 0;
        else
            state_display = ~state_display;
    end
    
    wire [3:0]r1_out;

    // Register
    register R1 (
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .load(btn_store),
        .r_out(state_display),
        .data(sw),
        .q(r1_out)
     );
     
     assign led = state_display ? r1_out : 4'b0000;
endmodule
