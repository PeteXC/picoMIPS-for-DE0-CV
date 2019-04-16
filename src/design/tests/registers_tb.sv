//-----------------------------------------------------
// File Name : regstest.sv
// Function : testbench for pMIPS 16 x n registers, %0 == 0
// Version 1 : code template for Cyclone  MLAB
//             and true dual port sync RAM
// Author: tjk
// Last rev. 25 Oct 2012
//-----------------------------------------------------
`timescale 1ns/1ns

module registers_tb;

	parameter n = 8;

	logic clk, w;
	logic [n-1:0] Wdata;
	logic [3:0] srcAddr, dstAddr;
	wire [n-1:0] srcData, dstData;

	registers  #(.n(n)) GPR0(.*);

	initial
	begin
		clk =  0;
		#5  forever #5 clk = ~clk;
	end

	initial
	begin
		w = 1;
		srcAddr = 0; dstAddr = 0;
		Wdata = 0;
		#12

		dstAddr = 1;
		Wdata = 1;
		#10

		dstAddr = 2;
		Wdata = 2;
		#10

		dstAddr = 3;
		Wdata = 3;
		#10

		dstAddr = 4;
		Wdata = 4;
		#10

		dstAddr = 5;
		Wdata = 5;
		#10

		w = 0;
		srcAddr = 0; dstAddr = 1;
		#10

		srcAddr = 1; dstAddr = 2;
		#10

		srcAddr = 2; dstAddr = 3;
		#10

		srcAddr = 3; dstAddr = 4;
		#10

		srcAddr = 4; dstAddr = 5;

	end



endmodule // module regstest