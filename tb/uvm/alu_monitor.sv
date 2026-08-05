class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor);
    
    virtual dut_if.TB vif;

    uvm_analysis_port #(cmd_transaction) mon_analysis_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon_analysis_port = new("mon_analysis_port", this);
        // comment placeholder for uvm_config_db::get() to retrieve virtual interface
    endfunction

    virtual task run_phase(uvm_phase phase);
        cmd_transaction cmd_trans;

        forever begin
            @(posedge vif.result_valid)
            cmd_trans = cmd_transaction::type_id::create("cmd_trans", this);
            cmd_trans.exp_result = vif.result;
            cmd_trans.exp_zero = vif.zero;
            cmd_trans.exp_negative = vif.negative;
            cmd_trans.exp_carry_out = vif.carry_out;
            cmd_trans.exp_cmp_out = vif.cmp_out;
            mon_analysis_port.write(cmd_trans);
            @(negedge vif.result_valid)
        end
    endtask
endclass