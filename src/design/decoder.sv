//---------------------------------------------------------
// File Name   : decoder.sv
// Function    : picoMIPS instruction decoder
// Author: tjk
// ver 2:  // NOP, ADD, ADDI, and branches
// Last revised: 26 Oct 2012
//---------------------------------------------------------

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder(
	input wire loadSwitch,
	input logic [5:0] opcode, // top 6 bits of instruction
	// output signals
	//    PC control
	output logic PCincr,
	//    ALU control
	output logic [2:0] ALUfunc,
	// imm mux control
	output logic imm, inSwitch,
	//   register file control
	output logic w
	);

	//------------- code starts here ---------
	// instruction decoder

	always_comb
	begin
		// set default output signal values for NOP instruction
		PCincr = 1'b1; // PC increments by default
		ALUfunc = 3'`RA;
		imm=1'b0; w=1'b0;
		takeBranch =  1'b0;

		case(opcode)

			`LDI: begin
				ALUfunc = `RB;
				imm = 1'b1;
				w = 1'b1;
			end

			`LDS: begin
				PCincr = loadSwitch;
				w = 1'b1;
				ALUfunc = `RB;
				imm = 1'b1;
				inSwitch = 1'b1;
			end

			`ADD: begin // register-register
				w = 1'b1; // write result to dest register
				ALUfunc = `RADD;
			end

			`ADDI: begin
				w = 1'b1;
				imm = 1'b1;
				ALUfunc = `RADD;
			end

			`MUL: begin // register-immediate
				w = 1'b1; // write result to dest register
				ALUfunc = `RMUL;
			end

			`MULI: begin // register-immediate
				w = 1'b1; // write result to dest register
				imm = 1'b1;
				ALUfunc = `RMUL;
			end

			`WAIT0: begin
				PCincr = ~inSwitch;
			end

			`WAIT1: begin
				PCincr = inSwitch;
			end
			default:
				$error("unimplemented opcode %h",opcode);

		endcase // opcode

	end // always_comb


endmodule //module decoder --------------------------------