`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2018 10:58:52 PM
// Design Name: 
// Module Name: register_controller
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


module register_controller(
    input clk,
    input n_rst,
    input [1:0] mode,
    input [2:0] func,
    output wire [2:0] r_in,
    output wire [2:0] r_out,
    output wire d_in
    );
    parameter [2:0] IDLE = 3'b000,
        STORE_IN = 3'b001,
        STORE_OUT = 3'b010,
        DISPLAY = 3'b011,
        SWAP_IN = 3'b100;
 
 
    reg [2:0]active_func;
    reg [2:0]state;
    reg [2:0]next_state;
    reg [2:0]last_mode;
    
    always @(func, state, n_rst) begin
        if(!n_rst) begin
            next_state = IDLE;
            active_func = 0'b000;
        end
        else if(last_mode != mode) begin
            active_func = 0;
            next_state = IDLE;
        end
        else if(func != 0) begin
           active_func = func;
           case(mode)
           0'b00: next_state = STORE_IN;
           0'b01: next_state = DISPLAY;
           0'b10: next_state = SWAP_IN;
           endcase
        end
        else begin
           active_func = active_func;
           case(state)
           STORE_IN: next_state = STORE_OUT;
           STORE_OUT: next_state = IDLE;
           DISPLAY: next_state = DISPLAY;
           SWAP_IN: next_state = IDLE;           
           endcase
        end
           
    end
    
    always @(posedge clk) begin
        last_mode = mode;
        state = next_state;
    end

    assign r_in = state == STORE_IN ? active_func :
                  state == STORE_OUT ? active_func : 0;

    assign r_out = state == DISPLAY ? active_func : 0;
    
    assign d_in = state == STORE_IN ? 1 : 
                  state == STORE_OUT ? 1 : 0;  
    
endmodule