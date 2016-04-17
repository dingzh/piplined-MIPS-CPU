`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:33:56 03/10/2016
// Design Name:   Top
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab6/test_isim_top.v
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

module test_isim_top;

	// Inputs
	reg CLOCK_IN;
	reg RESET;
	reg [2:0] SWITCH;

	// Outputs
	wire [3:0] LED;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.CLOCK_IN(CLOCK_IN), 
		.RESET(RESET), 
		.SW(SWITCH), 
		.LED(LED)
	);
	always #10 CLOCK_IN = ~CLOCK_IN;
	initial begin
		// Initialize Inputs
		CLOCK_IN = 0;
		RESET = 1;
		SWITCH = 2'b001;

		// Wait 100 ns for global reset to finish
		#120;
        
		// Add stimulus here
	RESET = 0;
	end
      
endmodule

