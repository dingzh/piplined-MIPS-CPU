`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:34:23 02/26/2016
// Design Name:   Alu
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab3/test_for_Alu.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_Alu;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg [3:0] aluCtr;

	// Outputs
	wire zero;
	wire [31:0] aluRes;

	// Instantiate the Unit Under Test (UUT)
	Alu uut (
		.input1(input1), 
		.input2(input2), 
		.aluCtr(aluCtr), 
		.zero(zero), 
		.aluRes(aluRes)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		aluCtr = 0;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
		#100
		begin
			input1 = 255;
			input2 = 170;
			aluCtr = 'b0000;
		end
		#100
		begin
			input1 = 255;
			input2 = 170;
			aluCtr = 'b0001;
		end
		#100
		begin
			input1 = 1;
			input2 = 1;
			aluCtr = 'b0010;
		end
		#100
		begin
			input1 = 255;
			input2 = 170;
			aluCtr = 'b0110;
		end
		#100
		begin
			input1 = 1;
			input2 = 1;
			aluCtr = 'b0110;
		end
		#100
		begin
			input1 = 255;
			input2 = 170;
			aluCtr = 'b0111;
		end
		#100
		begin
			input1 = 170;
			input2 = 255;
			aluCtr = 'b0111;
		end
		#100
		begin
			input1 = 0;
			input2 = 1;
			aluCtr = 'b1100;
		end
	end
      
endmodule

