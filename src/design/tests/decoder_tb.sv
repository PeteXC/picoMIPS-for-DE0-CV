//---------------------------------------------------------
// File Name   : decodertest.sv
// Function    : testbench for picoMIPS instruction decoder
// Author: tjk
// ver 1:  // only NOP, ADD, ADDI
// Last revised: 26 Oct 2012
//---------------------------------------------------------

`include "../alucodes.sv"
`include "../opcodes.sv"

`timescale 1ns/1ns
//---------------------------------------------------------
module decoder_tb;

	logic [2:0] opcode; // top 6 bits of instruction
	logic loadSwitch;
	//    PC control, imm MUX control, register file control
	wire PCincr, imm, inSwitch, w;
	//    ALU control
	wire [2:0] ALUfunc;

	decoder DCR0 (.*);

	initial
	begin
		opcode = `WAIT1;
		loadSwitch = 1'b0;
		#20

		loadSwitch = 1'b1;
		opcode = `LDS;
		#10

		opcode = `WAIT0;
		#10

		loadSwitch = 1'b0;
		opcode = `LDI;
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