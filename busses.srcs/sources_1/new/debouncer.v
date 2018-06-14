`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2018 02:40:45 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input n_rst,
    input btn,
    output q
    );
    parameter hold_threshold = 5_000_000;
    parameter [1:0] IDLE = 2'b00, DOWN = 2'b01, UP = 2'b10, TRIG = 2'b11;
         
    reg [31:0] hold_counter;
    reg [1:0] next_state;
    reg [1:0] state;
    
    always @(btn, state, hold_counter)
    begin
        case(state)
            IDLE: if(btn)
                    next_state = DOWN;
                  else
                    next_state = TRIG;
//            DOWN: if(btn)
//                    next_state = DOWN;
//                  else if(hold_counter >= hold_threshold)
//                    next_state = UP;
//                  else
//                    next_state = IDLE;
//            UP:    if(btn)
//                    next_state = IDLE;
//                   else if(hold_counter >= hold_threshold)
//                    next_state = TRIG;
//                   else
//                    next_state = UP;
           TRIG:   next_state = IDLE;
       endcase;
    end

    always @(posedge clk)
    begin
//        if(state == DOWN && next_state == UP || state == IDLE || state == TRIG)
//            hold_counter = 0;
//        else if(hold_counter < hold_threshold)
//            hold_counter = hold_counter + 1;
//        else
//            hold_counter = hold_counter;
            
        if(n_rst == 0)
        begin
            state = IDLE;
            next_state = IDLE;
//            hold_counter = 0;
        end
        else
            state = next_state;
    end
    
    assign q = state == TRIG;
endmodule
