//-----------------------------------------------------
// File Name : regstest.sv
// Function : testbench for pMIPS 32 x n registers, %0 == 0
// Version 1 : code template for Cyclone  MLAB
//             and true dual port sync RAM
// Author: tjk
// Last rev. 25 Oct 2012
//-----------------------------------------------------
module regs_tb;

	parameter n = 8;

	logic clk, w;
	logic [n-1:0] Wdata;
	logic [4:0] Raddr1, Raddr2;
	logic [n-1:0] Rdata1, Rdata2;

	regs  #(.n(n)) r(.*);

	initial
	begin
		clk =  0;
		#5ns  forever #5ns clk = ~clk;
	end

	initial
	begin
		w = 1;
		Raddr1 = 1; Raddr2 = 2;
		Wdata = 11;

		#12ns w = 0;
		#10ns Wdata = 8'hFF;
		#10ns w = 1;
		#10ns Raddr2 = 0; // test reg %0
	end



endmodule // module regstest