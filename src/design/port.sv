//  Module: port
//
module port(
    input wire portStart, loadSwitch,
    input wire [7:0] dataSwitch,
    output logic w, portDone,
    output logic [7:0] outData
    );

    always_comb begin
        if (portStart == 0) begin
            w = 0;
            portDone = 0;
            outData = 8'b00000000;
        end else begin
            if (loadSwitch == 0) begin

            end else begin

            end
        end
    end

    logic thisState, lastState;

    always_ff @(posedge clk, posedge portStart) begin

        thisState <= loadSwitch;

        if (portStart == 0) begin
            w = 0;
            portDone = 0;
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
                        w <= 0;
                        lastState <= thisState;
                    end

                end

                default:    lastState <= thisState;
            endcase
        end
    end
endmodule
