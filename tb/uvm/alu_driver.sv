class alu_driver extends uvm_driver #(cmd_transaction);
    `uvm_component_utils(alu_driver);

    virtual dut_if.TB vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // comment placeholder for uvm_config_db::get() to retrieve virtual interface
    endfunction

    virtual task run_phase (uvm_phase phase);
        cmd_transaction cmd_trans;

        forever begin
            wait (!vif.full)
            seq_item_port.get_next_item(cmd_trans);
            vif.tb_cb.write_data <= {cmd_trans.opcode, cmd_trans.a, cmd_trans.b};
            vif.tb_cb.write_enable <= 1;
            @(vif.tb_cb)
            vif.tb_cb.write_enable <= 0;
            
            seq_item_port.item_done();
        end
    endtask
endclass