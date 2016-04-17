`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:56 02/26/2016 
// Design Name: 
// Module Name:    signExt 
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
module signExt(
    input [15:0] inst,
    output [31:0] data
    );
	 
	 assign data = $signed(inst);


endmodule
