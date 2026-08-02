typedef mailbox #(cmd_transaction) cmd_mbx;

class generator;
    cmd_mbx drv_mail; // driver mailbox
    cmd_mbx exp_mail; // scoreboard mailbox
    int num_transactions; // Number of transactions to generate

    function new(cmd_mbx drv_mail, cmd_mbx exp_mail);
        this.drv_mail = drv_mail;
        this.exp_mail = exp_mail;
        num_transactions = 10;
    endfunction

    task run();
        cmd_transaction #() cmd1;
        for (int i = 0; i < num_transactions; i++) begin
            cmd1 = new();
            assert (cmd1.randomize());
            cmd1.compute_expected();
            cmd1.print();
            drv_mail.put(cmd1); // To driver
            exp_mail.put(cmd1); // To scoreboard
        end
    endtask
endclass