`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:57 02/26/2016 
// Design Name: 
// Module Name:    Register 
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
module Register(
    input clock_in,
    input regWrite,
    input [4:0] readReg1,  //address to be read1
    input [4:0] readReg2,
    input [4:0] writeReg,			//address to be write
    input [31:0] writeData,
    output reg [31:0] readData1,  
    output reg [31:0] readData2
    );
	 
	 reg [31:0] regFile[31:0];	 
	 
	 always @(readReg1 or readReg2 or posedge clock_in)
	 begin
	 readData1 = regFile[readReg1];
	 readData2 = regFile[readReg2];
	 end
	 
	 always @(negedge clock_in)
	 begin
	 if(regWrite)
		regFile[writeReg] = writeData;
	 end


endmodule
