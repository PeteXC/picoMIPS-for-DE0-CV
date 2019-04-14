//-----------------------------------------------------
// File Name   : alu.sv
// Function    : ALU module for picoMIPS
// Version: 1,  only 8 funcs
// Author:  tjk
// Last rev. 23 Oct 12
//-----------------------------------------------------

// V = flags[3] = overflow
// N = flags[2] = negative
// Z = flags[1] = zero
// C = flags[0] = carry on msb

`include "alucodes.sv"
module alu #(parameter n =8) (
	input logic [n-1:0] a, b, // ALU operands
	input logic [2:0] func, // ALU function code
	output logic [n-1:0] result // ALU result
	);
	//------------- code starts here ---------

	// create an n-bit adder
	// and then build the ALU around the adder
	logic[n-1:0] ar,b1; // temp signals

	// always_comb
	// begin
	// 	if(func==`RSUB)
	// 		b1 = b;
	// 		ar = a+b1; // n-bit adder
	// end // always_comb

	assign ar = a + b;

	 // Generic 8-to-16-bit signed multiplier
    logic signed [((2*N)-1):0] mr;
    assign mr = a * b;

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
				result = mr;
			end

		endcase

	end //always_comb

endmodule //end of module ALU


