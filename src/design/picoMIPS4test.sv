// synthesise to run on Altera DE0 for testing and demo
module picoMIPS4test(
	input wire fastclk,  // 50MHz Altera DE0 clock
	input wire reset,
	input wire [8:0] SW, // Switches SW0..SW7 and one for load
	output logic [7:0] LEDR); // LEDs

	logic clk; // slow clock, about 10Hz

	counter c (.fastclk(fastclk),.clk(clk)); // slow clk from counter

	// to obtain the cost figure, synthesise your design without the counter
	// and the picoMIPS4test module using Cyclone IV E as target
	// and make a note of the synthesis statistics
	cpu #(.n(8)) CPU01 (.clk(clk), .reset(reset), .loadSwitch(SW[8]), .dataSwitch(SW[7:0]), .outport(LEDR));

endmodule