class scoreboard;
    cmd_mbx exp_mbx;
    cmd_mbx act_mbx;
    int pass_count;
    int fail_count;

    function new(cmd_mbx exp_mbx, cmd_mbx act_mbx);
        this.exp_mbx = exp_mbx;
        this.act_mbx = act_mbx;
        this.pass_count = 0;
        this.fail_count = 0;
    endfunction

    task run();
        cmd_transaction exp_trans;
        cmd_transaction act_trans;

        forever begin
            exp_trans = new();
            act_trans = new();
            
            exp_mbx.get(exp_trans);
            act_mbx.get(act_trans);

            if (exp_trans.compare(act_trans)) begin
                pass_count += 1;
            end
            else begin
                fail_count += 1;
            end
        end
    endtask

    function report();
        $display("SCOREBOARD STATS: Tests ran = %d | Passed = %d | Failed = %d", (pass_count + fail_count), pass_count, fail_count);
    endfunction
endclass