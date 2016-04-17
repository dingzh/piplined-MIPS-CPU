`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:21:26 03/31/2016
// Design Name:   Top
// Module Name:   C:/Users/Ranolazine/Desktop/board_eelab_final_back/lab5_v1/test.v
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

module test;

	// Inputs
	reg CLOCK;
	reg RESET;
	reg [2:0] SW;

	// Outputs
	wire [3:0] LED;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.CLOCK(CLOCK), 
		.RESET(RESET), 
		.SW(SW), 
		.LED(LED)
	);
	always #15 CLOCK = ~CLOCK;
	initial begin
		// Initialize Inputs
		CLOCK = 0;
		RESET = 1;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
      RESET = 0 ;
		// Add stimulus here

	end
      
endmodule

