package tb_pkg;
    `include "cmd_transaction.sv"
    typedef mailbox #(cmd_transaction) cmd_mbx;
    `include "generator.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "scoreboard.sv"
    `include "env.sv"
endpackage