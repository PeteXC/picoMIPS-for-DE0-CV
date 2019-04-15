module pc_tb;

    parameter Psize = 5;

    logic clk, reset, PCincr;
    wire [Psize - 1 : 0] PCout;

    pc #(.Psize(Psize)) PRC01(.*);


    initial
	begin
		clk =  0;
		#5ns  forever #5ns clk = ~clk;
	end

    initial
    begin
        // Test reset and if PCIncr works with and without PCrelbranch
        reset = 1;
        PCincr = 1;
        #10ns
        reset = 0;
        #20ns

        // Test if  PCincr works
        PCincr = 0;
        #40ns
        PCincr = 1;
    end

endmodule