class driver;
    virtual dut_if.TB vif;
    cmd_mbx mail;

    function new(virtual dut_if.TB vif, cmd_mbx mail);
        this.vif = vif;
        this.mail = mail;
    endfunction

    task run();
        cmd_transaction cmd1;
        forever begin
            cmd1 = new();
            mail.get(cmd1);
            wait (!vif.full);
            vif.tb_cb.write_data <= {cmd1.opcode, cmd1.a, cmd1.b};
            vif.tb_cb.write_enable <= 1;
            @(vif.tb_cb);
            vif.tb_cb.write_enable <= 0;
        end
    endtask

endclass