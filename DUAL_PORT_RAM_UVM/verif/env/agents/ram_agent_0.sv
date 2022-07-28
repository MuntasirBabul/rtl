`ifndef RAM_AGENT_0
`define RAM_AGENT_0
`include "uvm_macros.svh"

class ram_agent_0 extends uvm_agent;

uvm_sequencer #(ram_seq_item)   seqr_0;
ram_driver_0                    drvr_0;
ram_monitor_0                   mntr_0;

`uvm_component_utils(ram_agent_0);

// constructor //
function new(string name, uvm_component parent)
    super.new(name, parent)
endfunction:new

// build_phase //
function void build_phase(uvm_phase phase)
    super.build_phase(phase);
    //seqr_0 = ram_sequencer_0::type_id::create("seqr_0", this);
    seqr_0 = new("seqr_0", this);
    drvr_0 = ram_driver_0::type_id::create("drvr_0", this);
    mntr_0 = ram_monitor_0::type_id::create("mntr_0", this);
endfunction:build_phase

// connect phase //
function void connect_phase(uvm_phase phase)
    super.connect_phase(phase);
    drvr_0.seq_item_port.connect(seqr_0.seq_item_export);
endfunction:connect_phase

endclass
`endif