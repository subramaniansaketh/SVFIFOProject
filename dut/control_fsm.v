module control_fsm (
                        input clk,
                        input reset,
                        input empty,
                        output reg read_enable,
                        output reg capture_enable,
                        output reg result_valid
                   );
        
        parameter IDLE = 0,
                  POP = 1,
                  EXEC = 2,
                  DONE = 3;
        
        reg [1:0] curr_state, next_state;

        // Sequential next-state logic
        always @(posedge clk) begin
            if (reset) begin
                curr_state <= IDLE;
            end
            else begin
                curr_state <= next_state;
            end
        end

        always @(*) begin
            read_enable = 0;
            capture_enable = 0;
            result_valid = 0;
            case (curr_state) 
                IDLE: begin
                    if (empty) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = POP;
                    end
                end
                POP: begin
                    next_state = EXEC;
                    read_enable = 1;
                end
                EXEC: begin
                    next_state = DONE;
                    capture_enable = 1;
                end
                DONE: begin
                    next_state = IDLE;
                    result_valid = 1;
                end
                default: next_state = IDLE;
            endcase
        end

endmodule