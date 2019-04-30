//  Module: port
//
module port(
    input wire portStart, loadSwitch, clk,
    input wire [7:0] dataSwitch,
    output logic w, portDone, dispX2, dispY2
    );

    // always_comb begin
    //     if (portStart == 0) begin
    //         w = 0;
    //         portDone = 0;
    //         outData = 8'b00000000;
    //     end else begin
    //         if (loadSwitch == 0) begin

    //         end else begin

    //         end
    //     end
    // end

    logic thisState, lastState;

    always_ff @(posedge clk, posedge portStart) begin

        thisState <= loadSwitch;
        dispX2 <= 0;
        dispY2 <= 0;

        if (portStart == 0) begin
            w <= 0;
            portDone <= 0;
            lastState <= thisState;
        end else begin

            case(thisState)

                0:  begin

                    if ( thisState == lastState ) begin
                        dispX2 <= 1;
                        lastState <= thisState;
                    end else begin
                        dispX2 <= 1;
                        portDone <= 1;
                        w <= 0;
                        lastState <= thisState;
                    end
                end

                1:  begin

                    if ( thisState == lastState ) begin
                        dispY2 <= 1;
                        lastState <= thisState;
                    end else begin
                        dispY2 <= 1;
                        portDone <= 0;
                        w <= 1;
                        lastState <= thisState;
                    end

                end

                default:    lastState <= thisState;

            endcase

        end

    end


endmodule
