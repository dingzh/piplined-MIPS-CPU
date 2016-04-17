`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:50 03/01/2016 
// Design Name: 
// Module Name:    instructionMemory 
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
module instructionMemory(
    input [31:0] address,
    input clock_in,
    input reset,
    output [31:0] readData
    );
	 wire [31:0] index;
	 assign index = address;
	 reg [31:0] memBuffer [0:63];
	 initial $readmemb("./src/inst.txt",memBuffer);	 
	 
	 assign readData= memBuffer[index];

endmodule
