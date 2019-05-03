module signed_mult (
    output logic signed [15:0] out,
    input  wire signed [7:0] a, b );

    assign out = a * b;

endmodule