interface dut_if #(parameter WIDTH = 8) (input logic clk);
    logic reset;
    logic write_enable;
    logic [(2 * WIDTH + 4) - 1: 0] write_data;
    logic [WIDTH - 1: 0] result;
    logic full;
    logic carry_out;
    logic zero;
    logic negative;
    logic [2:0] cmp_out;
    logic result_valid;

    clocking tb_cb @(posedge clk); // Clocking block for testbench - removes hardcoded simulation delays
        default input #1step output #1;
        input full, result, carry_out, zero, negative, cmp_out,
        result_valid;
        output reset, write_data, write_enable;
    endclocking

    modport DUT 
    (
        input reset, write_enable, write_data,
        output full, result, carry_out, zero, negative, 
        cmp_out, result_valid
    );

    modport TB (clocking tb_cb);

    assert property (@(posedge clk) result_valid |-> ##1 !result_valid)
        else $display("Result valid must only pulse for one cycle!");
    assert property (@(posedge clk) full & write_enable |-> !result_valid)
        else $display("Result valid mustn't fire spuriously");

endinterface