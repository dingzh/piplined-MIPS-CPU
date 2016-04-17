`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:46:13 04/03/2016
// Design Name:   dataMemory
// Module Name:   C:/Users/Ranolazine/Desktop/lab5_better_io/test_mem.v
// Project Name:  lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dataMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mem;

	// Inputs
	reg clock_in;
	reg [31:0] address;
	reg [31:0] writeData;
	reg memWrite;
	reg memRead;

	// Outputs
	wire [31:0] readData;

	// Instantiate the Unit Under Test (UUT)
	dataMemory uut (
		.clock_in(clock_in), 
		.address(address), 
		.writeData(writeData), 
		.readData(readData), 
		.memWrite(memWrite), 
		.memRead(memRead)
	);
	always #100 clock_in = ~clock_in;
	initial begin
		// Initialize Inputs
		clock_in = 0;
		address = 0;
		writeData = 0;
		memWrite = 0;
		memRead = 0;

		#185;
      
		address  = 32'b00000000000000000000000000001111;
		writeData= 32'b00000000000000001111111111111111;
		#250;
		memWrite = 1;
		#200;
		memRead = 1;
		memWrite= 0;
		

	end
      
endmodule

