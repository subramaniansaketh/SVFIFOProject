module alu_tb;

localparam WIDTH = 8;

reg [WIDTH - 1: 0] a;
reg [WIDTH - 1: 0] b;
reg [3:0] opcode;
wire [WIDTH - 1: 0] result;
wire zero;
wire carry_out;
wire negative;
wire [2:0] cmp_out;

alu d1 (
        .a(a), .b(b), .opcode(opcode),
        .result(result), .zero(zero), 
        .carry_out(carry_out), .negative(negative),
        .cmp_out(cmp_out)
       );

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);

    a = 8'b00000001;
    b = 8'b00000001;
    opcode = 4'b0000;
    #1;
    $display("Result = %d | COut = %d | Negative : %d | Zero : %d", result, carry_out, negative, zero);

    a = 8'b11111111;
    b = 8'b01011011;
    opcode = 4'b0000;
    #1;
    $display("Result = %d | COut = %d | Negative : %d | Zero : %d", result, carry_out, negative, zero);

    a = 8'b00000010;
    b = 8'b00000001;
    opcode = 4'b0001;
    #1;
    $display("Result = %d | COut = %d | Negative : %d | Zero : %d", result, carry_out, negative, zero);

    a = 8'b00000001;
    b = 8'b00000001;
    opcode = 4'b0001;
    #1;
    $display("Result = %d | COut = %d | Negative : %d | Zero : %d", result, carry_out, negative, zero);

    a = 8'b11001100;
    b = 8'b00111111;
    opcode = 4'b0010;
    #1;
    $display("Result = %d | Negative : %d | Zero : %d", result, negative, zero);

    a = 8'b11001100;
    b = 8'b00111111;
    opcode = 4'b0011;
    #1;
    $display("Result = %d | Negative : %d | Zero : %d", result, negative, zero);

    a = 8'b11001100;
    b = 8'b00111111;
    opcode = 4'b0100;
    #1;
    $display("Result = %d | Negative : %d | Zero : %d", result, negative, zero);

    a = 8'b11001100;
    opcode = 4'b0101;
    #1;
    $display("Result = %d | Negative : %d | Zero : %d", result, negative, zero);

    a = 8'b11001100;
    opcode = 4'b0110;
    #1;
    $display("Result = %d | Negative : %d | Zero : %d", result, negative, zero);

    a = 8'b11001100;
    opcode = 4'b0111;
    #1;
    $display("Result = %d | Negative : %d | Zero : %d", result, negative, zero);

    a = 8'b11001100;
    b = 8'b00111111;
    opcode = 4'b1000;
    #1;
    $display("GT = %d | EQ : %d | LT : %d", cmp_out[0], cmp_out[1], cmp_out[2]);

    a = 8'b00000000;
    b = 8'b01100110;
    opcode = 4'b1000;
    #1;
    $display("GT = %d | EQ : %d | LT : %d", cmp_out[0], cmp_out[1], cmp_out[2]);

    a = 8'b11111111;
    b = 8'b11111111;
    opcode = 4'b1000;
    #1;
    $display("GT = %d | EQ : %d | LT : %d", cmp_out[0], cmp_out[1], cmp_out[2]);

    a = 8'b11001100;
    opcode = 4'b1001;
    #1;
    $display("Result = %d | Negative : %d | Zero : %d", result, negative, zero);

end

endmodule