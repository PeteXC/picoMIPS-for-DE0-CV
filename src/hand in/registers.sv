module registers #(parameter n = 8) // n - data bus width
	(input logic clk, w, // clk and write control
	input logic [n-1:0] Wdata,
	input logic [3:0] srcAddr1, srcAddr2,
	input logic [1:0] dstAddr,
	output logic [n-1:0] srcData1, srcData2, dstData, outX2, outY2);

	// Declare 4 n-bit registers
	logic [n-1:0] gpr [3:0];


	// write process to the dstAddr
	always_ff @ (posedge clk)
	begin
		if (w)
			gpr[dstAddr] <= Wdata;
	end

	assign srcData1 = gpr[srcAddr1[1:0]];
	assign srcData2 = gpr[srcAddr2[1:0]];
	assign dstData = gpr[dstAddr];
	assign outX2 = gpr[2];
	assign outY2 = gpr[3];

endmodule // module regs