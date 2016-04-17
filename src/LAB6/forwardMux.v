`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:51:39 04/06/2016 
// Design Name: 
// Module Name:    forwardMux 
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
module forwardMux(
    input [31:0] ID_EX,
    input [31:0] EX_MEM,
    input [31:0] MEM_WB,
    input [1:0] Forward,
    output [31:0] Sel
    );
	 wire [31:0] TEMP;
	 assign Sel =  Forward[1] ? EX_MEM : TEMP;
	 assign TEMP=	Forward[0] ? MEM_WB : ID_EX;
endmodule
