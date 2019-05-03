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
	logic [3:0] srcAddr1, srcAddr2;
	logic [1:0] dstAddr;
	wire [n-1:0] srcData1, srcData2, dstData, outX2, outY2;

	registers  #(.n(n)) GPR0(.*);

	initial
	begin
		clk =  0;
		#5  forever #5 clk = ~clk;
	end

	initial
	begin
		w = 1;
		srcAddr1 = 4'b0000; srcAddr2 = 4'b0000;
		dstAddr = 4'b00;
		Wdata = 8'b00000000;
		#12

		dstAddr = 4'b01;
		Wdata = 8'b00000001;
		#10

		dstAddr = 4'b10;
		Wdata = 8'b00000010;
		#10

		dstAddr = 4'b11;
		Wdata = 8'b00000011;
		#10

		w = 0;
		srcAddr1 = 4'b0000; srcAddr2 = 4'b0001;
		#10

		srcAddr1 = 4'b0001; srcAddr2 = 4'b0010;
		#10

		srcAddr1 = 4'b0010; srcAddr2 = 4'b0011;

	end



endmodule // module regstest