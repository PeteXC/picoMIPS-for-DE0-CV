`include "../alucodes.sv"
module alu_tbAffine;

    parameter n = 8;

	logic [n-1:0] a, b; // ALU operands
	logic [2:0] func; // ALU function code
	logic [n-1:0] result; // ALU result

    alu #(.n(n)) ALU0(.*);

    initial
    begin
        // Test RMUL
        a = 8'b00001100;
        b = 8'b11000000;
        func = `RMUL;

        // Test RMUL for negative
        #20ns
        a = 8'b10111100;
        b = 8'b01100000;
        func = `RMUL;

    end

endmodule