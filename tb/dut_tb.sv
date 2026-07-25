module dut_tb;

logic clk;

dut_if.TB bus (.clk(clk));
fifo_alu_dut d0 (.bus(bus));

always #5 clk = ~clk;

initial begin
    $dumpfile("dut.vcd");
    $dumpvars(0, dut_tb);

    bus.clk = 0;
    bus.reset = 1;
    bus.write_enable = 0;
    bus.write_data = 0;

    @(bus.tb_cb);
    bus.reset = 0; 

    bus.tb_cb.write_enable <= 1;
    bus.tb_cb.bus.write_data <= {4'b0000, 8'b00110011, 8'b01010010};
    @(bus.tb_cb);
    bus.tb_cb.write_enable <= 0;
    @(posedge bus.result_valid) begin
        $display("Result = %d | Zero: %d | COut: %d | Negative: %d", bus.result, bus.zero, bus.carry_out, bus.negative);
    end
    @(negedge bus.result_valid);

    @(bus.tb_cb);
    @(bus.tb_cb);


    bus.tb_cbwrite_enable <= 1;
    bus.tb_cb.write_data <= {4'b0001, 8'b01110011, 8'b01010010};
    @(bus.tb_cb);
    bus.tb_cb.write_enable <= 0;
    @(posedge bus.result_valid) begin
        $display("Result = %d | Zero: %d | COut: %d | Negative: %d", bus.result, bus.zero, bus.carry_out, bus.negative);
    end
    @(negedge bus.result_valid);
    
    @(bus.tb_cb);
    @(bus.tb_cb);

    bus.tb_cb.write_enable <= 1;
    bus.tb_cb.write_data <= {4'b0010, 8'b01110011, 8'b01010010};
    @(bus.tb_cb);
    bus.tb_cb.write_enable <= 0;
    @(posedge bus.result_valid) begin    
        $display("Result = %d | Zero: %d | Negative: %d", bus.result, bus.zero, bus.negative);
    end
    @(negedge bus.result_valid);
    
    @(bus.tb_cb);
    @(bus.tb_cb);

    bus.tb_cb.write_enable <= 1;
    bus.tb_cb.write_data = {4'b1000, 8'b01110011, 8'b01010010};
    @(bus.tb_cb);
    bus.write_enable <= 0;
    @(posedge bus.result_valid) begin
        $display("GT = %d | EQ: %d | LT: %d", bus.cmp_out[0], bus.cmp_out[1], bus.cmp_out[2]);
    end
    @(negedge bus.result_valid);
    
    @(bus.tb_cb);
    @(bus.tb_cb);

    bus.tb_cb.write_enable <= 1;
    bus.tb_cb.write_data <= {4'b1001, 8'b01110011, 8'b01010010};
    @(bus.tb_cb);
    bus.tb_cb.write_enable <= 0;
    @(posedge bus.result_valid) begin
        $display("Set bits = %d", bus.result);
    end
    @(negedge bus.result_valid);
    
    @(bus.tb_cb);
    @(bus.tb_cb);

    bus.reset = 0;
    
    $finish;

end

endmodule