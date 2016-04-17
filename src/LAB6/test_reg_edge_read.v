`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:30:22 03/02/2016
// Design Name:   Register
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab6/test_reg_edge_read.v
// Project Name:  lab6
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

module test_reg_edge_read;

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
		.readData2(readData2)
	);

	initial begin
		// Initialize Inputs
		clock_in = 0;
		regWrite = 1;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		writeData = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		
		#10;
		writeData = 'b11111111111111111111111111111111;
		
		
		
	end
      
endmodule

