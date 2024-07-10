`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2024 20:18:52
// Design Name: 
// Module Name: fifo
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


module fifo #(parameter no_of_words = 3, bits_per_word = 8)(
    input logic clk, areset,
    input logic write, read,
    input logic [bits_per_word - 1 : 0] write_data,
    output logic [bits_per_word - 1 : 0] read_data,
    output logic full, empty
);

    logic [no_of_words - 1 : 0] write_address, read_address;
    
    fifo_control #(.no_of_words(no_of_words))
        control(.*);
    
    fifo_register #(.no_of_words(no_of_words), .bits_per_word(bits_per_word))
        register(.w_en(write & ~full), .*);
    
endmodule
