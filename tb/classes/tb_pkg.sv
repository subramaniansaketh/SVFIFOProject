package tb_pkg;
    typedef mailbox #(cmd_transaction) cmd_mbx;
    `include "cmd_transaction.sv"
    `include "generator.sv"
    `include "driver.sv"
    `include "monitor.sv";
    `include "scoreboard.sv";
    `include "env.sv";
endpackage