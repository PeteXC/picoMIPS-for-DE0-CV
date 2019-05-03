`include "alucodes.sv"
module alu #(parameter n =8) (
	input wire signed [n-1:0] a, b, // ALU operands
	input wire [2:0] func, // ALU function code
	output logic signed [n-1:0] result // ALU result
	);
	//------------- code starts here ---------

	// create an n-bit adder
	// and then build the ALU around the adder
	logic signed [n-1:0] ar; // temp signals

	assign ar = a + b;

	// Create 8-to-16-bit signed multiplier
	wire signed [((2*n)-1):0] mr;
	signed_mult MUL0 (
		.a(a),
		.b(b),
		.out(mr) );


	// create the ALU, use signal ar in arithmetic operations
	always_comb
	begin
		//default output values; prevent latches
		result = a; // default
		case(func)

			`RA		: result = a;

			`RB		: result = b;

			`RADD	: begin
				result = ar; // arithmetic addition
			end

			`RMUL	: begin
				result = mr[((n-1)*2):(n-1)];
			end

			default	: result = a;

		endcase

	end //always_comb

endmodule //end of module ALU


