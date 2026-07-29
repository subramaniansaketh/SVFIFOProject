class generator;
    typedef mailbox #(cmd_transaction) cmd_mbx;
    cmd_mbx mail;
    int num_transactions; // Number of transactions to generate

    function new(cmd_mbx mail);
        this.mail = mail;
        num_transactions = 10;
    endfunction

    task run();
        for (int i = 0; i < num_transactions; i++) begin
            cmd_transaction #() cmd1 = new();
            assert (cmd1.randomize());
            cmd1.compute_expected();
            cmd1.print();
            mbx.put(cmd1);
        end
    endtask
endclass