`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder(
	input wire loadSwitch, portDone,
	input wire [2:0] opcode, // top 3 bits of instruction
	// output signals
	//    PC control
	output logic PCincr,
	//    ALU control
	output logic [2:0] ALUfunc,
	// imm mux control
	output logic imm, switchControl, portStart,
	//   register file control
	output logic w
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
		imm=1'b0; w=1'b0; switchControl=1'b0;
		portStart = 1'b0;
		// opType = 0;

		case(opcode)

			`LDI: begin
				ALUfunc = `RB;
				imm = 1'b1;
				w = 1'b1;
				// opType = 0;
			end

			`LDP: begin
				if (portDone == 0) begin

					portStart = 1'b1;
					ALUfunc = `RB;
					PCincr = 1'b0;
					switchControl = 1'b1;
					imm = 1'b1;

				end else begin

					ALUfunc = `RB;
					portStart = 1'b0;
					switchControl = 1'b0;
					PCincr = 1'b1;

				end
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


			// `WAIT0: begin
			// 	w = 1'b0;
			// 	inSwitch = 1'b1;
			// 	dispY2 = 1;
			// 	PCincr = ~loadSwitch;
			// end

			// `WAIT1: begin
			// 	w = 1'b0;
			// 	inSwitch = 1'b1;
			// 	dispX2 = 1;
			// 	PCincr = loadSwitch;
			// end

			default:
				$error("unimplemented opcode %h",opcode);

		endcase // opcode

	end // always_comb


endmodule //module decoder --------------------------------