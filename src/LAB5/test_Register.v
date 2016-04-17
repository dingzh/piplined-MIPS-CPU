`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:36:03 02/26/2016
// Design Name:   Register
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab4/test_Register.v
// Project Name:  lab4
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

module test_Register;

	// Inputs
	reg clock_in;
	reg regWrite;
	reg [4:0] readReg1;
	reg [4:0] readReg2;
	reg [4:0] writeReg;
	reg [31:0] writeData;

	// Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;
	
	parameter PERIOD = 200;

	// Instantiate the Unit Under Test (UUT)
	Register uut (
		.clock_in(clock_in), 
		.regWrite(regWrite), 
		.readReg1(readReg1), 
		.readReg2(readReg2), 
		.writeReg(writeReg), 
		.writeData(writeData), 
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

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here
		#285;
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
	end
      
endmodule

