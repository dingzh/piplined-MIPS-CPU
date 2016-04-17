`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:01:29 04/03/2016
// Design Name:   Register
// Module Name:   C:/Users/Ranolazine/Desktop/lab5_better_io/test_for_reg.v
// Project Name:  lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_reg;

	// Inputs
	reg clock_in;
	reg regWrite;
	reg [4:0] readReg1;
	reg [4:0] readReg2;
	reg [4:0] writeReg;
	reg [31:0] writeData;
	reg reset;

	// Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;
	wire [31:0] reg1;
	wire [31:0] reg2;

	// Instantiate the Unit Under Test (UUT)
	Register uut (
		.clock_in(clock_in), 
		.regWrite(regWrite), 
		.readReg1(readReg1), 
		.readReg2(readReg2), 
		.writeReg(writeReg), 
		.writeData(writeData), 
		.reset(reset), 
		.readData1(readData1), 
		.readData2(readData2), 
		.reg1(reg1), 
		.reg2(reg2)
	);
	always #15 clock_in = ~clock_in;
	initial begin
		// Initialize Inputs
		clock_in = 0;
		regWrite = 0;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		writeData = 0;
		reset = 1;
		

		#40;
		reset = 0;
		readReg1 = 'b01;
		readReg2 = 'b10;
		writeReg = 'b01;
		writeData = 255;
		
		#30;
		regWrite = 1;
		writeReg = 'b10;
		#30;
		writeData = 233;
		writeReg  = 'b11;
		#30;
		readReg1 = 'b11;
		

	end
      
endmodule

