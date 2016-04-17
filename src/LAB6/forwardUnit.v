`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:27 04/07/2016 
// Design Name: 
// Module Name:    forwardUnit 
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
module forwardUnit(
    input [4:0] rs,
    input [4:0] rt,
    input MEM_WB_regWrite,
    input [4:0] MEM_WB_rd,
    input EX_MEM_regWrite,
    input [4:0] EX_MEM_rd,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB,
	 input rst
    );
	 
	 //forwardA
	 always @(*)	begin
	 if(rst)	begin
		forwardA = 'b00;
		forwardB = 'b00;
		end
	else
		begin
	 
		if(MEM_WB_regWrite & MEM_WB_rd != 0 & MEM_WB_rd == rs)	forwardA = 'b01;
		else if(EX_MEM_regWrite & EX_MEM_rd != 0 & EX_MEM_rd == rs) forwardA = 'b10;
			else forwardA = 'b00;
		
		if(MEM_WB_regWrite & MEM_WB_rd != 0 & MEM_WB_rd == rt)	forwardB = 'b01;
		else if(EX_MEM_regWrite & EX_MEM_rd != 0 & EX_MEM_rd == rt) forwardB = 'b10;
			else forwardB = 'b00;
		end
	 end

endmodule
