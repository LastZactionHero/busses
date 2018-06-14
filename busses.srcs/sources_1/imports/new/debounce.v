`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 11:19:40 PM
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk,
    input n_rst,
    input btn,
    output trig
    );
    parameter n = 50_000_000;
    parameter [1:0] UP = 2'b00, DOWN = 2'b01, TRIGGER = 2'b10;
    
    wire clkd;
    reg [1:0] state;
    reg [1:0] next_state;
    
    clk_div CD (
      .clk(clk),
      .n_rst(n_rst),
      .c(clkd)
    );
    defparam CD.n = n;
    
    always @(btn, state) begin
        case(state)
        UP: if(btn)
                next_state = DOWN;
            else
                next_state = UP;
        DOWN:
            if(btn)
                next_state = DOWN;
            else
                next_state = TRIGGER;
        TRIGGER: next_state = UP;
        endcase;
    end
    
    always @(posedge clk) begin
        if(n_rst == 0)
            state = UP;
        else if(clkd)
            state = next_state;
    end
    
    assign trig = state == TRIGGER;
    

endmodule
