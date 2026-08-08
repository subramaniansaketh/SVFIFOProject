class alu_env extends uvm_env;
    `uvm_component_utils(alu_env);

    alu_agent agent1;
    scoreboard scoreboard1;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent1 = alu_agent::type_id::create("agent", this);
        scoreboard1 = scoreboard::type_id::create("scoreboard", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        agent1.monitor.mon_analysis_port.connect(scoreboard1.ap_imp); // connects to uvm_analysis_imp in scoreboard
    endfunction
endclass