//  Module: port
//
module port(
    input wire portStart, loadSwitch, clk,
    output logic w, portDone
    );

    logic thisState, lastState;

    always_ff @(posedge clk) begin

        if (portStart == 0) begin
            w <= 0;
            portDone <= 0;
            lastState <= thisState;
        end else begin

            case(thisState)

                0:  begin

                    if ( thisState == lastState ) begin
                        lastState <= thisState;
                    end else begin
                        portDone <= 1;
                        w <= 0;
                        lastState <= thisState;
                    end
                end

                1:  begin

                    if ( thisState == lastState ) begin
                        lastState <= thisState;
                    end else begin
                        portDone <= 0;
                        w <= 1;
                        lastState <= thisState;
                    end

                end

                default:    lastState <= thisState;

            endcase

        end

    end

    assign thisState = loadSwitch;

endmodule
