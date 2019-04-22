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
	input wire [2:0] opcode, // top 3 bits of instruction
	// output signals
	//    PC control
	output logic PCincr,
	//    ALU control
	output logic [2:0] ALUfunc,
	// imm mux control
	output logic imm, inSwitch,
	//   register file control
	output logic w, dispX2, dispY2
	//	1 for dst-src1-src2, 0 for dst-src
	// output logic opType
	);

	//------------- code starts here ---------
	// instruction decoder

	always_comb
	begin
		// set default output signal values for NOP instruction
		PCincr = 1'b1; // PC increments by default
		ALUfunc = `RA;
		imm=1'b0; w=1'b0; inSwitch=1'b0;
		dispX2 = 0; dispY2 = 0;
		// opType = 0;

		case(opcode)

			`LDI: begin
				ALUfunc = `RB;
				imm = 1'b1;
				w = 1'b1;
				// opType = 0;
			end

			`LDS: begin
				PCincr = loadSwitch;
				w = 1'b1;
				ALUfunc = `RB;
				imm = 1'b1;
				inSwitch = 1'b1;
				// opType = 0;
			end

			`ADD: begin // register-register
				w = 1'b1; // write result to dest register
				ALUfunc = `RADD;
				// opType = 1;
			end

			`ADDI: begin
				w = 1'b1;
				imm = 1'b1;
				ALUfunc = `RADD;
				// opType = 0;
			end

			`MUL: begin // register-immediate
				w = 1'b1; // write result to dest register
				ALUfunc = `RMUL;
				// opType = 1;
			end

			`MULI: begin // register-immediate
				w = 1'b1; // write result to dest register
				imm = 1'b1;
				ALUfunc = `RMUL;
				// opType = 0;
			end

			`WAIT0: begin
				w = 1'b0;
				inSwitch = 1'b1;
				dispY2 = 1;
				PCincr = ~loadSwitch;
			end

			`WAIT1: begin
				w = 1'b0;
				inSwitch = 1'b1;
				dispX2 = 1;
				PCincr = loadSwitch;
			end

			default:
				$error("unimplemented opcode %h",opcode);

		endcase // opcode

	end // always_comb


endmodule //module decoder --------------------------------