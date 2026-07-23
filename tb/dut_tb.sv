module dut_tb;

localparam WIDTH = 8;

logic clk,
    reset,
    write_enable;
logic[(2 * WIDTH + 4) - 1 : 0] write_data;

logic full;
logic [WIDTH - 1: 0] result;
logic carry_out,
     zero,
     negative;
logic [2:0] cmp_out;
logic result_valid;

fifo_alu_dut d0 (
                    .clk(clk), .reset(reset),
                    .write_enable(write_enable),
                    .write_data(write_data), .full(full),
                    .result(result), .zero(zero), .negative(negative),
                    .cmp_out(cmp_out), .result_valid(result_valid),
                    .carry_out(carry_out)
                 );

always #5 clk = ~clk;

initial begin
    $dumpfile("dut.vcd");
    $dumpvars(0, dut_tb);

    reset = 1;
    clk = 0;
    write_enable = 0;
    write_data = 0;

    #10;
    reset = 0; 

    write_enable = 1;
    write_data = {4'b0000, 8'b00110011, 8'b01010010};
    #10;
    write_enable = 0;
    @(posedge result_valid) begin
        $display("Result = %d | Zero: %d | COut: %d | Negative: %d", result, zero, carry_out, negative);
    end
    @(negedge result_valid);
    #20;

    write_enable = 1;
    write_data = {4'b0001, 8'b01110011, 8'b01010010};
    #10;
    write_enable = 0;
    @(posedge result_valid) begin
        $display("Result = %d | Zero: %d | COut: %d | Negative: %d", result, zero, carry_out, negative);
    end
    @(negedge result_valid);
    #20;

    write_enable = 1;
    write_data = {4'b0010, 8'b01110011, 8'b01010010};
    #10; 
    write_enable = 0;
    @(posedge result_valid) begin    
        $display("Result = %d | Zero: %d | Negative: %d", result, zero, negative);
    end
    @(negedge result_valid);
    #20;

    write_enable = 1;
    write_data = {4'b1000, 8'b01110011, 8'b01010010};
    #10;
    write_enable = 0;
    @(posedge result_valid) begin
        $display("GT = %d | EQ: %d | LT: %d", cmp_out[0], cmp_out[1], cmp_out[2]);
    end
    @(negedge result_valid);
    #20;

    write_enable = 1;
    write_data = {4'b1001, 8'b01110011, 8'b01010010};
    #10;
    write_enable = 0;
    @(posedge result_valid) begin
        $display("Set bits = %d", result);
    end
    @(negedge result_valid);
    #20;

    reset = 0;
    
    $finish;

end

endmodule