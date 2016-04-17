`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:25:14 03/13/2016 
// Design Name: 
// Module Name:    timerDivider 
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
module timerDivider(
    input clk_in,
    output reg clk_out
    );
	 
	 reg[23:0] buffer;
	 
	 always@(posedge clk_in)
	 begin
		buffer <= buffer +1;
		clk_out <= &buffer;
	 end


endmodule
