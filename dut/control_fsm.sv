module control_fsm (
                        input logic clk,
                        input logic reset,
                        input logic empty,
                        output logic read_enable,
                        output logic capture_enable,
                        output logic result_valid
                   );

        typedef enum logic [1:0] {IDLE, POP, EXEC, DONE} state_t;
        
        state_t curr_state, next_state;

        // Sequential next-state logic
        always_ff @(posedge clk) begin
            if (reset) begin
                curr_state <= IDLE;
            end
            else begin
                curr_state <= next_state;
            end
        end

        always_comb begin
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