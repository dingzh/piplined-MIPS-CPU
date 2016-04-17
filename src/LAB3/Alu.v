`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:49 02/26/2016 
// Design Name: 
// Module Name:    Alu 
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
module Alu(
    input [31:0] input1,    
	 input [31:0] input2,
    input [3:0] aluCtr,
    output reg zero,
    output reg [31:0] aluRes
    );
	 always @(input1 or input2 or aluCtr)
	 begin
	 case(aluCtr)
	   'b0000:	begin                     //AND		
		aluRes = input1 & input2;
		zero = 0;
		end
		'b0001:  begin                     //OR		
		aluRes = input1 | input2;
		zero = 0;
		end
		'b0010:  begin                     //add		
		aluRes = input1 + input2;
		zero = 0;
		end
		'b0110:  begin                     //sub  		
			aluRes = input1 - input2;
			if(aluRes == 0)	zero = 1;				
			else zero = 0;
		end
		'b0111:  begin		//set on less than		
			zero = 0;
			if(input1<input2)  aluRes = 1;
			else aluRes = 0;
		end
		'b1100:  begin               		  //NOR		
			aluRes = ~(input1 | input2);
			zero = 0;
		end
	endcase
	end
endmodule
