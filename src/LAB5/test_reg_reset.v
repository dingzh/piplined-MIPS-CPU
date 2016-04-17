`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:06:29 02/27/2016
// Design Name:   Register
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab5/test_Reg_with_reset.v
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

module test_Reg_with_reset;

	// Inputs
	reg clock_in;
	reg regWrite;
	reg [4:0] readReg1;
	reg [4:0] readReg2;
	reg [4:0] writeReg;
	reg [31:0] writeData;
	reg reset;
	
   parameter PERIOD = 100;
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
	always #(PERIOD/2) clock_in = ~clock_in;
	initial begin
		// Initialize Inputs
		clock_in = 0;
		regWrite = 0;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		writeData = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
      
		// Add stimulus here
		#185;
		regWrite = 'b1;
		writeReg = 5'b10101;
		writeData = 32'b11111111111111110000000000000000;
		
		#200;
		writeReg = 5'b01010;
		writeData = 32'b00000000000000001111111111111111;
		
		#200;
		regWrite = 'b0;
		writeReg = 'b00000;
		writeData = 32'b00000000000000000000000000000000;
		
		#50;
		readReg1 = 'b10101;
		readReg2 = 'b01010;
		
		#20;
		reset = 'b1;
		
	end
      
endmodule

