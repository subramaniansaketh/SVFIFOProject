module dut_tb;
    logic clk;

    dut_if.TB bus (.clk(clk));
    fifo_alu_dut d1 (.bus(bus));

    always #5 clk = ~clk;
    initial clk = 0;

    initial begin
        $dumpfile("dut_tb.vcd");
        $dumpvars(0, dut_tb);

        env env1 = new(bus);
        bus.reset = 1;

        repeat(2) @(bus.tb_cb);

        bus.reset = 0;

        env1.run();
        repeat (env1.g1.num_transactions * 10) @(bus.tb_cb);
        env1.s1.report();
        $finish;

    end
endmodule