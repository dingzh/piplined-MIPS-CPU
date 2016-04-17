`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:31:56 02/26/2016
// Design Name:   AluCtr
// Module Name:   C:/Users/Ranolazine/Desktop/Lab/lab3/test_for_AluCtr.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AluCtr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_AluCtr;

	// Inputs
	reg [1:0] aluOp;
	reg [5:0] funct;

	// Outputs
	wire [3:0] aluCtr;

	// Instantiate the Unit Under Test (UUT)
	AluCtr uut (
		.aluOp(aluOp), 
		.funct(funct), 
		.aluCtr(aluCtr)
	);

	initial begin
		// Initialize Inputs
		aluOp = 0;
		funct = 0;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
		#100 
		begin
		  aluOp = 'b00;
		  funct = 'b111111;
		end
		#100 
		begin
		  aluOp = 'b01;
		  funct = 'b111111;
		end
		#100 
		begin
		  aluOp = 'b10;
		  funct = 'b100000;
		end
		#100 
		begin
		  aluOp = 'b10;
		  funct = 'b100010;
		end
		#100 
		begin
		  aluOp = 'b10;
		  funct = 'b100100;
		end
		#100 
		begin
		  aluOp = 'b10;
		  funct = 'b100101;
		end
		#100 
		begin
		  aluOp = 'b10;
		  funct = 'b101010;
		end

	end
      
endmodule

