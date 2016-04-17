`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:03:17 03/01/2016
// Design Name:   Pc
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab5/test_pc_.v
// Project Name:  lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_pc_;

	// Inputs
	reg clock_in;
	reg [31:0] nextPC;
	reg rst;

	// Outputs
	wire [31:0] currPC;

	// Instantiate the Unit Under Test (UUT)
	Pc uut (
		.clock_in(clock_in), 
		.nextPC(nextPC), 
		.currPC(currPC), 
		.rst(rst)
	);
	always #5 clock_in = ~clock_in;
	initial begin
		// Initialize Inputs
		clock_in = 0;
		nextPC = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		nextPC = 'b11111111111111111111111111111111;
		rst = 0;
		
		
		#100;
		nextPC = 'b00000000000000000000000000010000;
		
		
		#100;
		rst =1;
        
		// Add stimulus here

	end
      
endmodule

