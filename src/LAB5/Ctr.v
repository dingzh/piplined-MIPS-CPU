`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:56:24 02/25/2016 
// Design Name: 
// Module Name:    Ctr 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Ctr(
	input [5:0] opCode,
	output reg regDst,
	output reg aluSrc,
	output reg memToReg,
	output reg regWrite,
	output reg memRead,
	output reg memWrite,
	output reg branch,
	output reg [1:0] aluOp,
	output reg jump
	);
	 
	 
	 always @(opCode)
	 begin
	 case (opCode)
	       6'b000010:
			 //jump
			 begin
			     regDst = 0;
				  aluSrc = 0;
				  memToReg = 0;
				  regWrite = 0;
				  memRead = 0;
				  memWrite = 0;
				  branch =0;
				  aluOp = 2'b00;
				  jump = 1;
		    end
			 6'b000000:
			 //R-format
			 begin
			     regDst = 1;
				  aluSrc = 0;
				  memToReg = 0;
				  regWrite = 1;
				  memRead = 0;
				  memWrite = 0;
				  branch = 0;
				  aluOp =  2'b10;   
				  //which one is the MSB?
				  jump = 0;
			 end
			 6'b100011:
			 //lw
			 begin
			     regDst = 0;
				  aluSrc = 1;
				  memToReg = 1;
				  regWrite = 1;
				  memRead = 1;
				  memWrite = 0;
				  branch = 0;
				  aluOp =  2'b00;   
				  jump = 0;
			 end
			 6'b101011:
			 //sw
			 begin
			     regDst = 1; //don't care term
				  aluSrc = 1;
				  memToReg = 1; //don't care term
				  regWrite = 0;
				  memRead = 0;
				  memWrite = 1;
				  branch = 0;
				  aluOp =  2'b00;   
				  jump = 0;
			 end
			 6'b000100:
			 //beq
			 begin
			     regDst = 0;  //don't care term
				  aluSrc = 0;
				  memToReg = 0;  //don't care term
				  regWrite = 0;
				  memRead = 0;
				  memWrite = 0;
				  branch = 1;
				  aluOp =  2'b01;   
				  jump = 0;
			 end
			 default:
			 begin
			     regDst = 0;
				  aluSrc = 0;
				  memToReg = 0;
				  regWrite = 0;
				  memRead = 0;
				  memWrite = 0;
				  branch = 0;
				  aluOp =  2'b00;   
				  jump = 0;
			 end
		endcase
		end
		
endmodule

