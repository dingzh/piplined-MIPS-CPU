`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:43:27 04/04/2016
// Design Name:   Top
// Module Name:   C:/Users/Ranolazine/Desktop/lab5_better_io/test_for_top.v
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

module test_for_top;

	// Inputs
	reg CLOCK;
	reg RESET;
	reg [2:0] MODE;
	reg FAST;

	// Outputs
	wire [7:0] LED;
	
	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.CLOCK(CLOCK), 
		.RESET(RESET), 
		.MODE(MODE), 
		.LED(LED), 
		.FAST(FAST)
	);
	always #10 CLOCK=~CLOCK;
	initial begin
		// Initialize Inputs
		CLOCK = 0;
		RESET = 1;
		MODE = 0;
		FAST = 0;

		// Wait 100 ns for global reset to finish
		#100;
      RESET = 0;  
		// Add stimulus here

	end
      
endmodule

