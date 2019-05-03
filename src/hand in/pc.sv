module pc #(parameter Psize = 5) // up to 32 instructions in total
	(input logic clk, reset, PCincr,
	output logic [Psize-1 : 0]PCout
	);

	//------------- code starts here---------

	always_ff @ ( posedge clk or posedge reset) // async reset
	begin
		if (reset) // sync reset
			PCout <= {Psize{1'b0}};
		else if (PCincr)
			PCout <= PCout + 1'b1;
		else
			PCout = PCout;
	end

endmodule // module pc