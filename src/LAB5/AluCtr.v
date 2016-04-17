`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:08:40 02/26/2016 
// Design Name: 
// Module Name:    AluCtr 
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
module AluCtr(
    input [1:0] aluOp,
    input [5:0] funct,
    output reg [3:0] aluCtr
    );
	
		always @ (aluOp or funct)
		casex ({aluOp, funct})
		  8'b00xxxxxx: aluCtr = 'b0010;
		  8'b01xxxxxx: aluCtr = 'b0110;
		  8'b10100000: aluCtr = 'b0010;
		  8'b10100010: aluCtr = 'b0110;
		  8'b10100100: aluCtr = 'b0000;
		  8'b10100101: aluCtr = 'b0001;
		  8'b10101010: aluCtr = 'b0111;
		  default:  aluCtr = 'b0000;
		endcase
		
		  
		  

endmodule
