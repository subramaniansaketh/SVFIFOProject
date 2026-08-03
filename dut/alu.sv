module alu #(parameter WIDTH = 8)
            (
                input logic [WIDTH - 1: 0] a,
                input logic [WIDTH - 1: 0] b,
                input logic [3:0] opcode,
                output logic [WIDTH - 1: 0] result,
                output logic zero, // wire 
                output logic carry_out,
                output logic negative, // wire
                output logic [2:0] cmp_out
            );

        integer i;
        integer set_count;

        always_comb begin
            set_count = 0;
            result = 0;
            carry_out = 0;
            cmp_out = 0;

            case (opcode) 
                4'b0000: begin
                    {carry_out, result} = a + b;
                end
                4'b0001: begin
                    {carry_out, result} = a - b;
                end
                4'b0010: begin
                    result = a & b;
                end
                4'b0011: begin
                    result = a | b;
                end
                4'b0100: begin
                    result = a ^ b;
                end
                4'b0101: begin
                    result = ~a;
                end
                4'b0110: begin
                    result = a << 1'b1;
                end
                4'b0111: begin
                    result = a >> 1'b1;
                end
                4'b1000: begin
                    cmp_out = {a < b, a == b, a > b};
                end
                4'b1001: begin
                    for (i = 0; i < WIDTH; i = i + 1) begin
                        if (a[i]) begin
                            set_count = set_count + 1;
                        end
                    end
                    result = set_count;
                end
                default: result = '0;
            endcase
        end

        assign zero = (result == 0);
        assign negative = (result[WIDTH - 1] == 1);
  

endmodule