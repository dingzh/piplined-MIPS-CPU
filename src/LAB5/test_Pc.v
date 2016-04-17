`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:26:57 02/28/2016
// Design Name:   Pc
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab5/test_Pc.v
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

module test_Pc;

	// Inputs
	reg clock_in;
	reg [31:0] nextPC;

	// Outputs
	wire [31:0] currPC;

	// Instantiate the Unit Under Test (UUT)
	Pc uut (
		.clock_in(clock_in), 
		.nextPC(nextPC), 
		.currPC(currPC)
	);
	always #10 clock_in = ~clock_in;
	initial begin
		// Initialize Inputs
		clock_in = 0;
		nextPC = 0;

		// Wait 100 ns for global reset to finish
		#105;
        
		// Add stimulus here
		nextPC = 32'b00000000000000000000000000001111;
		
		#15;
		nextPC = 32'b00000000000000000000000000011011;
		
		#20;
		nextPC = 32'b00000000000111111111111100011011;
		

	end
      
endmodule

