`include "../alucodes.sv"
module alu_tb;

    parameter n = 8;

	logic [n-1:0] a, b; // ALU operands
	logic [2:0] func; // ALU function code
	logic [n-1:0] result; // ALU result

    alu #(.n(n)) ALU0(.*);

    initial
    begin
        // Test RA and RB
        a = 4;
        func = `RA;
        #10ns
        b = 5;
        func = `RB;

        // Test RADD
        #20ns
        a = 1;
        b = 3;
        func = `RADD;

        // Test RSUB
        #20ns
        a = 5;
        b = 3;
        func = `RMUL;

        #20ns
        a = 9;
        b = 9;
        func = `RMUL;

    end

endmodule