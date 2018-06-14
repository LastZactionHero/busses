`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2018 10:48:52 AM
// Design Name: 
// Module Name: busloader
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


module busloader(
    input CLK100MHZ,
    input [3:0] sw,
    input [3:0] btn,
    output [3:0] led,
    output led0_b,
    output led1_b
    );
    parameter hold_threshold = 50_000_000;

    reg n_rst;
    wire [2:0] r_in;
    wire [2:0] r_out;
    wire d_in;
    wire [3:0] bus;
    wire [3:0] btn_db;
    wire [1:0] mode;
    
    // Reset if first and last buttons are pressed together
    always @(posedge CLK100MHZ) begin
        n_rst = ~(btn[0] && btn[3]);
    end

    // Button Debouncers
    debounce #(.n(hold_threshold)) DB0 (
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .btn(btn[0]),
        .trig(btn_db[0])
    );
    
    debounce #(.n(hold_threshold)) DB1 (
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .btn(btn[1]),
        .trig(btn_db[1])
    );
    
    debounce #(.n(hold_threshold)) DB2 (
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .btn(btn[2]),
        .trig(btn_db[2])
    );
    
    debounce #(.n(hold_threshold)) DB3 (
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .btn(btn[3]),
        .trig(btn_db[3])
    );

    
    // Registers
    register R1(
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .load(r_in[0]),
        .r_out(r_out[0]),
        .data(bus),
        .q(bus)
    );
   register R2(
         .clk(CLK100MHZ),
         .n_rst(n_rst),
         .load(r_in[1]),
         .r_out(r_out[1]),
         .data(bus),
         .q(bus)
   );
   register R3(
          .clk(CLK100MHZ),
          .n_rst(n_rst),
          .load(r_in[2]),
          .r_out(r_out[2]),
          .data(bus),
          .q(bus)
    );     

    // Mode Set
    mode_set MODE(
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .toggle(btn_db[0]),
        .mode(mode)
    );
    
    // Filter function buttons so only one can occur at a time
    wire [2:0] func;
    assign func =
        btn_db[3] ? 3'b100 :
        btn_db[2] ? 3'b010 :
        btn_db[1] ? 3'b001 :
        0;

    // Register Controller
    register_controller RegCtrl1(
        .clk(CLK100MHZ),
        .n_rst(n_rst),
        .mode(mode),
        .func(func),
        .r_in(r_in),
        .r_out(r_out),
        .d_in(d_in)
    );
    
    // Put switches on the bus if d_in set
    assign bus = d_in ? sw : 'bz;
    assign led0_b = mode[0];
    assign led1_b = mode[1];
    
    // LED always shows what's on the bus
    assign led = bus;
endmodule
