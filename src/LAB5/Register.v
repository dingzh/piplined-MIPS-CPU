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
	 input reset,
    output [31:0] readData1,  
    output [31:0] readData2,
	 output [31:0] reg1,
	 output [31:0] reg2
    );

	 reg [31:0] regFile[31:0];
	 initial $readmemh("./src/regFile.txt",regFile);
	 
	 
	 assign readData1 = regFile[readReg1];
	 assign readData2 = regFile[readReg2];
	 assign reg1 = regFile[1];
	 assign reg2 = regFile[2];
	 
	 always @(negedge clock_in)
	 begin
		 if(reset) $readmemh("./src/regFile.txt",regFile);			
	    else if(regWrite)	regFile[writeReg] = writeData;
				else;	 
	 end
endmodule
