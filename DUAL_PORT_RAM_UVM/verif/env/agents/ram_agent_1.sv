`ifndef RAM_AGENT_1
`define RAM_AGENT_1
`include "uvm_macros.svh"

class ram_agent_1 extends uvm_agent;

ram_sequencer_1 seqr_0;
ram_driver_1 drvr_1;
ram_monitor_1 mntr_1;

`uvm_component_utils(ram_agent_0);

// constructor //
function new(string name, uvm_component parent)
    super.new(name, parent)
endfunction:new

// build_phase //
function void build_phase(uvm_phase phase)
    super.build_phase(phase);
    seqr_1 = ram_sequencer_1::type_id::create("seqr_1", this);
    drvr_1 = ram_driver_1::type_id::create("drvr_1", this);
    mntr_1 = ram_monitor_1::type_id::create("mntr_1", this);
endfunction:build_phase

// connect phase //
function void connect_phase(uvm_phase phase)
    super.connect_phase(phase);
    drvr_1.seq_item_port.connect(seqr_1.seq_item_export);
endfunction:connect_phase

endclass
`endif