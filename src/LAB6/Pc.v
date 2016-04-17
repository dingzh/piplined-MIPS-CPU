`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:23:21 02/28/2016 
// Design Name: 
// Module Name:    Pc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Pc(
    input clock_in,
    input [31:0] nextPC,
    output[31:0] currPC,
	 input rst
    );
	 
	 reg [31:0] PCFile;
	 initial 
	 begin
		PCFile <= 'b00000000000000000000000000000000;
	 end 
	 
	 always @(posedge clock_in)
	 begin
		if(rst) PCFile <= 'b00000000000000000000000000000000;
		else PCFile <= nextPC;
	 end
	 
	
	 assign currPC = rst? 'b00000000000000000000000000000000 : PCFile;

endmodule
