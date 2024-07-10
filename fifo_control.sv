`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2024 20:18:52
// Design Name: 
// Module Name: fifo_control
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


module fifo_control #(parameter no_of_words = 3)(
    input logic clk, areset,
    input logic write, read,
    output logic full, empty,
    output logic [no_of_words - 1 : 0] write_address, read_address
    );
    
    logic [no_of_words - 1 : 0] w_current, w_next;
    logic [no_of_words - 1 : 0] r_current, r_next;
    logic full_next, empty_next;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            w_current <= 0;
            r_current <= 0;
            full <= 0;
            empty <= 1'b1;
        end
        else begin
            w_current <= w_next;
            r_current <= r_next;
            full <= full_next;
            empty <= empty_next; 
        end
    end
    
    always_comb begin
        w_next = w_current;
        r_next = r_current;
        full_next = full;
        empty_next = empty;
        case({write, read})
            2'b01: begin
                if (~empty) begin
                    r_next = r_current + 1'b1;
                    full_next = 1'b0;
                    if (r_next == w_current) empty_next = 1'b1;
                end
            end
            2'b10: begin
                if ( ~full) begin
                    w_next = w_current + 1'b1;
                    empty_next = 1'b0;
                    if (w_next == r_current) full_next = 1'b1;
                end
            end
            2'b11: begin
                if (empty) begin
                    w_next = w_current;
                    r_next = r_current;
                end
                else begin
                    r_next = r_current + 1'b1;
                    w_next = w_current + 1'b1;
                end
            end
            default: ;
        endcase
    end
    
    assign write_address = w_current;
    assign read_address = r_current;
    
endmodule
