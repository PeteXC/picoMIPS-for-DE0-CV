`timescale 1ns/1ns

module affine_tb;

    parameter n = 8;

    logic clk, reset, loadSwitch;
    logic [n-1:0] dataSwitch;
    wire [n-1:0] outport;

    initial
	begin
		clk =  0;
		#5  forever #5 clk = ~clk;
	end

    cpu     #(.n(n)) CPU01 (.*);

    initial begin
        loadSwitch = 0;
        dataSwitch = 8'b00000000;
        reset = 1;
        #10
        reset = 0;

        #20
        dataSwitch = 8'b00001100;

        #20
        loadSwitch = 1;

        #20
        loadSwitch = 0;

        #20
        dataSwitch = 8'b00100001;

        #20
        loadSwitch = 1;

        #20
        loadSwitch = 0;

        #400
        loadSwitch = 1;

    end

endmodule