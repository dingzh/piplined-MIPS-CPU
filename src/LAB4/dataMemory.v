`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:49:09 02/26/2016 
// Design Name: 
// Module Name:    dataMemory 
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
module dataMemory(
    input clock_in,
    input [31:0] address,
    input [31:0] writeData,
    output reg [31:0] readData,
    input memWrite,
    input memRead
    );
	 
	 reg [31:0] memFile [127:0];
	 
	 always @(memRead)
	 begin
		if(address/4<128)	readData = memFile[address/4];    //avoid unexpected error
		else readData = 32'b00000000000000000000000000000000;
	 end
	 
	 always @(negedge clock_in)
	 begin
		if(memWrite)  memFile[address/4] = writeData;
	 end


endmodule
