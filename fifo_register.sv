`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2024 20:18:52
// Design Name: 
// Module Name: fifo_register
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


module fifo_register #(parameter no_of_words = 3, bits_per_word = 8)(
    input logic clk, w_en,
    input logic [no_of_words-1:0] read_address, write_address,
    input logic [bits_per_word - 1 : 0] write_data,
    output logic [bits_per_word - 1 : 0] read_data
    );
    
    logic [bits_per_word - 1 : 0] memory [0 : 2**no_of_words - 1];
    
    always_ff @(posedge clk) begin
        if (w_en) memory[write_address] <= write_data;
    end
    
    assign read_data = memory[read_address];
endmodule
