`ifndef RAM_SEQUENCE_1
`define RAM_SEQUENCE_1

class ram_sequence_1 extends uvm_sequence#(ram_seq_item)
`uvm_object_utils(ram_sequence_1)
ram_seq_item seq;

function new(string name = "ram_sequence_1");
    super.new(name);
endfunction

`uvm_declare_p_sequencer(ram_sequence_1)

virtual task body();
    repeat(5) begin 
        seq = ram_seq_item::type_id::create("seq");
        assert(seq.randomize()); // this is the main line needs to be changed for different sequence
        `uvm_info(get_full_name(), $sformatf("Randomized Tx from sequence."), UVM_LOW);
        seq.print();
        finish_item(seq);
    end
endtask
endclass

`endif