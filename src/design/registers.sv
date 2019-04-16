//-----------------------------------------------------
// File Name : registers.sv
// Function : picoMIPS 16 x n registers, %0 == 0
// Version 1 :
// Author: tjk
// Last rev. 27 Oct 2012
//-----------------------------------------------------
module registers #(parameter n = 8) // n - data bus width
	(input logic clk, w, // clk and write control
	input logic [n-1:0] Wdata,
	input logic [3:0] srcAddr, dstAddr,
	output logic [n-1:0] srcData, dstData);

	// Declare 16 n-bit registers
	logic [n-1:0] gpr [16:0];


	// write process, dst reg is Raddr2
	always_ff @ (posedge clk)
	begin
		if (w)
			gpr[dstAddr] <= Wdata;
	end

	// read process, output 0 if %0 is selected
	// always_comb
	// begin
	// 	if (srcAddr==4'd0)
	// 		srcData =  {n{1'b0}};	// If Raddr2 is 0, then the output is 0
	// 	else
	// 		srcData = gpr[srcAddr];

	// 	if (dstAddr==4'd0)
	// 		dstData =  {n{1'b0}};	// If Raddr2 is 0, then the output is 0
	// 	else
	// 		dstData = gpr[dstAddr];
	// end

	assign srcData = gpr[srcAddr];
	assign dstData = gpr[dstAddr];

endmodule // module regs