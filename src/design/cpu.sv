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
	wire [n-1:0] AluB, AluA; // output from imm MUX

	// registers
	wire [n-1:0] Rdata1, Rdata2, Rdata3, Wdata; // Register data
	wire w; // register write control

	// Program Counter
	parameter Psize = 5; // up to 64 instructions
	wire PCincr; // program counter control
	wire [Psize-1 : 0]ProgAddress;

	// ROM
	parameter Isize = n+6; // Isize - instruction width
	wire [Isize:0] I; // I - instruction code

	// Decorder
	// wire opType;

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
		.inSwitch(inSwitch) );

	registers   #(.n(n))
		GPR0 (
		.clk(clk),
		.w(w),
		.Wdata(Wdata),
		.srcAddr1(I[Isize-7:Isize-10]),  // reg %d number
		.srcAddr2(I[Isize-11:0]),
		.dstAddr(I[Isize-3:Isize-6]), // reg %s number
		.srcData1(Rdata1),
		.srcData2(Rdata2),
		.dstData(Rdata3) );

	alu    #(.n(n))
		ALU0 (
		.a(AluA),
		.b(AluB),
		.func(ALUfunc),
		.result(Wdata) ); // ALU result -> destination reg

	// create MUX for immediate operand
	assign AluB = (inSwitch ? dataSwitch : (imm ? I[n-1:0] : Rdata2));

	assign AluA = (imm ? Rdata3 : Rdata1);
	// this will take the lowest 8 bits of the instruction bus i.e. take the second operand as is


	// connect ALU result to outport
	assign outport = Wdata;

endmodule
