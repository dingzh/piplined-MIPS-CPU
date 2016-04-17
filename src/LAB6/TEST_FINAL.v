`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:50:02 04/07/2016
// Design Name:   Top
// Module Name:   C:/Users/Ranolazine/Desktop/board_eelab_final_back/lab6_v1/TEST_FINAL.v
// Project Name:  lab6
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

module TEST_FINAL;

	// Inputs
	reg CLOCK;
	reg RESET;
	reg [2:0] MODE;
	reg FAST;

	// Outputs
	wire [7:0] LED;
	always #15 CLOCK = ~CLOCK;
	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.CLOCK(CLOCK), 
		.RESET(RESET), 
		.MODE(MODE), 
		.LED(LED), 
		.FAST(FAST)
	);

	initial begin
		// Initialize Inputs
		CLOCK = 0;
		RESET = 1;
		MODE = 0;
		FAST = 1;

		// Wait 100 ns for global reset to finish
		#100;
      RESET = 0; 
		// Add stimulus here

	end
      
endmodule

