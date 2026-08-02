module mini_ALU #(parameter WIDTH = 8)
                 (
                    input logic [WIDTH - 1: 0] a, 
                    input logic [WIDTH - 1: 0] b,
                    input logic [2:0] op, 
                    output logic [WIDTH - 1: 0] result, 
                    output logic zero
                 );
        
        always_comb begin
            case (op)
                3'b000: begin
                    result = a + b;
                end
                3'b001: begin
                    result = a - b;
                end
                3'b010: begin
                    result = a & b;
                end
                3'b011: begin
                    result = a | b;
                end
                3'b100: begin
                    result = a ^ b;
                end
                3'b101: begin
                    result = ~a;
                end
                3'b110: begin
                    result = a << 1;
                end
                3'b111: begin
                    result = a >> 1;
                end
                default: result = 0;
            endcase
        end

        assign zero = (result == 8'b00000000);
endmodule