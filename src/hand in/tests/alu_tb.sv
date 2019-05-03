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

        // Test RADD for negative
        #20ns
        a = 8'b00001000;
        b = 8'b10111100;
        func = `RADD;

        // Test RMUL
        #20ns
        a = 5;
        b = 30;
        func = `RMUL;

        // Test RMUL for negative
        #20ns
        a = 8'b00001000;
        b = 8'b10111100;
        func = `RMUL;

    end

endmodule