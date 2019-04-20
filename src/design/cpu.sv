//------------------------------------
// File Name   : cpu.sv
// Function    : picoMIPS CPU top level encapsulating module, version 2
// Author      : tjk
// Ver 2 :  PC , prog memory, regs, ALU and decoder, no RAM
// Last revised: 27 Oct 2012
//------------------------------------

`include "alucodes.sv"
module cpu #( parameter n = 8) // data bus width
	(
	input wire clk,
	input wire reset, // master reset
	input wire loadSwitch,
	input wire [n-1:0] dataSwitch,
	output logic[n-1:0] outport // need an output port, tentatively this will be the ALU output
	);

	// declarations of local signals that connect CPU modules

	// ALU
	wire [2:0] ALUfunc; // ALU function
	wire imm; // immediate operand signal
	wire [n-1:0] Alub; // output from imm MUX

	// registers
	wire [n-1:0] Rdata1, Rdata2, Wdata; // Register data
	wire w; // register write control

	// Program Counter
	parameter Psize = 5; // up to 64 instructions
	wire PCincr; // program counter control
	wire [Psize-1 : 0]ProgAddress;

	// ROM
	parameter Isize = n+10; // Isize - instruction width
	wire [Isize:0] I; // I - instruction code

	// Decorder
	wire opType;

	//------------- code starts here ---------
	// module instantiations
	pc  #(.Psize(Psize))
		PRC0 (
		.clk(clk),
		.reset(reset),
		.PCincr(PCincr),
		.PCout(ProgAddress) );

	ROM #(.Psize(Psize),.Isize(Isize))
		ROM0 (
		.address(ProgAddress),
		.I(I) );

	decoder DCR0 (
		.loadSwitch(loadSwitch),
		.opcode(I[Isize:Isize-2]),
		.PCincr(PCincr),
		.ALUfunc(ALUfunc),
		.imm(imm),
		.w(w),
		.inSwitch(inSwitch)
		.opType(opType) );

	registers   #(.n(n))
		GPR0 (
		.clk(clk),
		.w(w),
		.Wdata(Wdata),
		.srcAddr(I[Isize-7:Isize-10]),  // reg %d number
		.dstAddr(I[Isize-3:Isize-6]), // reg %s number
		.srcData(Rdata1),
		.dstData(Rdata2) );

	alu    #(.n(n))
		ALU0 (
		.a(Rdata1),
		.b(Alub),
		.func(ALUfunc),
		.result(Wdata) ); // ALU result -> destination reg

	// create MUX for immediate operand
	assign Alub = (inSwitch ? dataSwitch : (opType ? I[n-5:0] : (imm ? I[n-1:0] : Rdata2)));
	// this will take the lowest 8 bits of the instruction bus i.e. take the second operand as is


	// connect ALU result to outport
	assign outport = Wdata;

endmodule
