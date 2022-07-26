`ifndef RAM_ENVIRONMENT
`define RAM_ENVIRONMENT
`include "uvm_macros.svh"
import uvm_pkg::*;

class ram_environment extends uvm_env;
`uvm_component_utils(axi_environment)

function new (string name, uvm_component parent);
    super.new(name,parent)
endfunction
    
ram_agent_0 agent_0;
ram_agent_1 agent_1;
ram_scoreboard scrbd;

// build phase //
function void build_phase(uvm_phase phase)
    super.build_phase(phase);
    agent_0 = ram_agent_0::type_id::create("agent_0", this);
    agent_1 = ram_agent_1::type_id::create("agent_1", this);
    scrbd   = ram_scoreboard::type_id::create("ram_scoreboard", this);
endfunction

// connect phase //

function void connect_phase(uvm_phase phase);
    agent_0.mntr_0.item_collected_port.connect(scrbd.item_collected_export);
    agent_1.mntr_1.item_collected_port.connect(scrbd.item_collected_export); // not sure
endfunction

endclass
`endif