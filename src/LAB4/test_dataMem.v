`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:13:12 02/27/2016
// Design Name:   dataMemory
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab4/test_dataMem.v
// Project Name:  lab4
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

module test_dataMem;

	// Inputs
	reg clock_in;
	reg [31:0] address;
	reg [31:0] writeData;
	reg memWrite;
	reg memRead;

	// Outputs
	wire [31:0] readData;
	parameter PERIOD = 200;
	// Instantiate the Unit Under Test (UUT)
	dataMemory uut (
		.clock_in(clock_in), 
		.address(address), 
		.writeData(writeData), 
		.readData(readData), 
		.memWrite(memWrite), 
		.memRead(memRead)
	);
	always #(PERIOD/2) clock_in = ~clock_in;
	initial begin
		// Initialize Inputs
		clock_in = 0;
		address = 0;
		writeData = 0;
		memWrite = 0;
		memRead = 0;

		// Wait 100 ns for global reset to finish
		#185;
		memWrite = 'b1;
		address = 32'b00000000000000000000000000000111;
		writeData = 32'b01111111111111111111111111111111;
        
		// Add stimulus here
		#250;
		memRead = 'b1;
		memWrite = 'b0;
	end
      
endmodule

