//  Module: port
//
module port(
    input wire portStart, loadSwitch, clk,
    input wire [7:0] dataSwitch,
    output logic w, portDone, dispX2, dispY2
    );

    logic thisState, lastState;

    always_ff @(posedge clk) begin

        if (portStart == 0) begin
            w <= 0;
            portDone <= 0;
            thisState <= loadSwitch;
            lastState <= thisState;
        end else begin

            thisState <= loadSwitch;
            dispX2 <= 0;
            dispY2 <= 0;

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
