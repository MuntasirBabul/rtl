`ifndef RAM_SEQUENCER_0
`define RAM_SEQUENCER_0
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "ram_seq_item.sv"

class ram_sequencer_0 extends uvm_sequencer#(axi_seq_item);
`uvm_component_utils(ram_sequencer_0);
	
function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction
endclass
