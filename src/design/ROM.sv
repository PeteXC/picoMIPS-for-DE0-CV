//-----------------------------------------------------
// File Name : prog.sv
// Function : Program memory Psize x Isize - reads from file prog.hex
// Author: tjk,
// Last rev. 24 Oct 2012
//-----------------------------------------------------
module ROM #(parameter Psize = 5, Isize = 19) // psize - address width, Isize - instruction width
	(input wire [Psize-1:0] address,
	output logic [Isize:0] I); // I - instruction code

	// program memory declaration, note: 1<<n is same as 2^n
	logic [Isize:0] memory[ (1<<Psize)-1:0];

	// get memory contents from file
	initial begin
		$readmemh("program.hex", memory);
	end
	// program memory read
	always_comb begin
		I = memory[address];
	end

endmodule // end of module prog
