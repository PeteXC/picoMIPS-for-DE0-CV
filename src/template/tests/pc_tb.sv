module pc_tb;

    parameter Psize = 6;

    logic clk, reset, PCincr, PCabsbranch, PCrelbranch;
    logic [Psize - 1 : 0] Branchaddr;
    wire [Psize - 1 : 0] PCout;

    pc #(.Psize(Psize)) PC01(.*);


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
        PCabsbranch = 0;
        PCrelbranch = 0;
        Branchaddr = 0;
        #10ns
        reset = 0;
        #10ns
        PCrelbranch = 1;
        #10ns
        PCrelbranch = 0;
        #20ns

        // Test if PCrelbranch works
        PCincr = 0;
        PCrelbranch = 1;
        Branchaddr = 10;
        #40ns
        PCrelbranch = 0;
        #10ns

        // Test if PCabsbranch works
        PCabsbranch = 1;
        Branchaddr = 5;

    end

endmodule