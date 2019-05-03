
`timescale 1ns/1ns

module ROM_tb;

	parameter Psize = 5, Isize = 12;

	logic [Psize-1:0] address;
	wire [Isize:0] I;

	ROM  #(.Psize(Psize), .Isize(Isize)) ROM0(.*);


	initial
	begin

        address = 5'b00000;
        #10

        address = 5'b00001;
        #10

        address = 5'b00010;
        #10

        address = 5'b00011;
        #10

        address = 5'b00100;
        #10

        address = 5'b00101;
        #10

        address = 5'b00110;
        #10

        address = 5'b00111;
        #10

        address = 5'b01000;

	end



endmodule