class env;
    virtual dut_if.TB vif;
    generator g1;
    driver d1;
    monitor m1;
    scoreboard s1;
    cmd_mbx act_mbx; // Mailbox handle storing actual transaction handle
    cmd_mbx drive_mbx;
    cmd_mbx exp_mbx; // Mailbox handle to scoreboard

    function new(virtual dut_if.TB vif);
        this.vif = vif;
        gen_mbx = new();
        drive_mbx = new();
        mon_mbx = new();
        exp_mbx = new();
        g1 = new(drv_mbx, exp_mbx);
        d1 = new(vif, drive_mbx);
        m1 = new(vif, act_mbx);
        s1 = new(exp_mbx, act_mbx);
    endfunction

    task run();
        fork
            g1.run();
            d1.run();
            m1.run();
            s1.run();
        join_none
    endtask
endclass