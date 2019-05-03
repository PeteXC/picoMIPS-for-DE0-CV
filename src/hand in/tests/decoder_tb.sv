`include "../alucodes.sv"
`include "../opcodes.sv"

`timescale 1ns/1ns
//---------------------------------------------------------
module decoder_tb;

	logic [2:0] opcode; // top 6 bits of instruction
	logic loadSwitch, portDone;
	//    PC control, imm MUX control, register file control
	wire PCincr, imm, switchControl, portStart, w;
	//    ALU control
	wire [2:0] ALUfunc;

	decoder DCR0 (.*);

	initial
	begin
		portDone = 0;
		loadSwitch = 1'b0;
		opcode = `LDI;
		#20

		opcode = `LDP;
		#20

		loadSwitch = 1'b1;
		#20

		loadSwitch = 1'b0;
		#20

		portDone = 1;
		#20

		opcode = `ADD;
		#20

		opcode = `ADDI;
		#20

		opcode = `MUL;
		#20

		opcode = `MULI;
		#20

		opcode = 3'bxxx;


	end

endmodule //module decoder --------------------------------