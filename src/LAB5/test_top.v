`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:04:43 03/14/2016
// Design Name:   Top
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab5/test_top.v
// Project Name:  lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_top;

	// Inputs
	reg clk;
	reg reset;
	reg [2:0] SW;

	// Outputs
	wire [3:0] LED;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.reset(reset), 
		.SW(SW), 
		.LED(LED)
	);
	always #10 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#125;
      reset = 0;  
		// Add stimulus here

	end
      
endmodule

