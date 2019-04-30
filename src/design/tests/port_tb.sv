`timescale 1ns/1ns

module port_tb;

    logic portStart, loadSwitch, clk;
    logic [7:0] dataSwitch;

    wire w, portDone, dispX2, dispY2;
    wire [7:0] outData;

    port POR0(.*);

    always begin
        #5 clk = ~clk;
    end

    initial begin

        clk = 0;
        portStart = 0;
        loadSwitch = 0;
        dataSwitch = 8'b00000000;

        #40
        portStart = 1;

        #20
        dataSwitch = 8'b01010101;

        #20
        loadSwitch = 1;

        #40
        loadSwitch = 0;

        #20
        if (portDone == 1) begin

            portStart = 0;

        end else begin

            portStart = 1;

        end

        #40
        portStart = 1;
        dataSwitch = 8'b10101010;

        #20
        loadSwitch = 1;

        #20
        loadSwitch = 0;

    end

endmodule