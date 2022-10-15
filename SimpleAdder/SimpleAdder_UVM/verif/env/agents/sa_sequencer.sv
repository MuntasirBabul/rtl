`ifndef SA_SEQUENCER
`define SA_SEQUENCER
`include "sa_seq_item.sv"

class sa_sequencer extends uvm_sequencer#(sa_seq_item);

    `uvm_component_utils(sa_sequencer)
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass
`endif