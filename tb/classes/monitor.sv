typedef mailbox #(cmd_transaction) cmd_mbx;

class monitor;
    virtual dut_if.TB vif;
    cmd_mbx mail;

    function new(virtual dut_if.TB vif, cmd_mbx mail);
        this.vif = vif;
        this.mail = mail;
    endfunction

    task run();
        cmd_transaction cmd1_output;
        forever begin
            cmd1_output = new();
            @(posedge vif.result_valid);
            cmd1_output.exp_result = vif.result;
            cmd1_output.exp_carry_out = vif.carry_out;
            cmd1_output.exp_zero = vif.zero;
            cmd1_output.exp_negative = vif.negative;
            cmd1_output.exp_cmp_out = vif.cmp_out;
            mail.put(cmd1_output);
            @(negedge vif.result_valid);
        end
    endtask
endclass