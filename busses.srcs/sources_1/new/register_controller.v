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
    parameter [2:0] IDLE = 3'b000, STORE = 3'b001, DISPLAY = 3'b010, SWAP_IN = 3'b011, SWAP_OUT = 3'b100;
 
    reg [2:0]state;
    reg [2:0]next_state;

    always @(mode, func) begin
        case(mode)
        00: begin
            if(func != 0 && state == IDLE)
                next_state = STORE;
            else
                next_state = IDLE;
        end
        01: begin
            if((func != 0 && state == IDLE) || (func == 0 && state == DISPLAY))
                next_state = DISPLAY;
            else
                next_state = IDLE;
        end
        02: begin
            if(func != 0 && state == IDLE)
                next_state = SWAP_IN;
            else if(state == SWAP_IN)
                next_state = SWAP_OUT;
            else
                next_state = IDLE;
        end
        endcase
    end
    
    always @(posedge clk)
    begin
        if(n_rst == 0) begin
            state = IDLE;
            next_state = IDLE;
        end
        else
            state = next_state;
    end
    
    assign r_in = state == IDLE ? 
        3'b000 : 
        state == STORE ? 
            3'b111 & func :
        3'b000;
    
//    case(state)
//    IDLE: begin
//        r_in = 0;
//        r_out = 0;
//        d_in = 0;
//    end
//    endcase
    
endmodule
