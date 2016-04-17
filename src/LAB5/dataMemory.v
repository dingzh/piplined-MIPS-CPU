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
    output wire [31:0] readData,
    input memWrite,
    input memRead												//memRead is actually not used
    );
	 initial $readmemh("./src/memFile.txt",memFile);		//intialize memory
	 
	 wire [31:0] index;
	 assign index = address>>2;							//data is fetched wordwise
	 reg [31:0] memFile [127:0];
	 assign readData= memFile[index];
	 	 
	 always @(negedge clock_in)
		if(memWrite)  memFile[index] <= writeData;
		
endmodule
