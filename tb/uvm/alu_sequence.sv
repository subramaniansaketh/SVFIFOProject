class alu_sequence extends uvm_sequence #(cmd_transaction);
    `uvm_object_utils(alu_sequence);

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction

    virtual task body();
        cmd_transaction cmd_trans;

        forever begin
            cmd_trans = cmd_transaction::type_id::create("cmd_trans");
            start_item(cmd_trans);
            assert(cmd_trans.randomize());
            finish_item(cmd_trans);
        end
    endtask
endclass