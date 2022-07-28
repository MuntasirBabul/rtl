`ifndef RAM_DRIVER_0
`define RAM_DRIVER_0
`include "uvm_macros.svh"
import uvm_pkg::*;

class ram_driver_0 extends uvm_driver #(ram_seq_item);

virtual ram_if vif;
int i = 0, j = 0, k = 0;
bit [31:0] temp_0[$];

`uvm_component_utils(ram_driver_0);

// Constructor //
function new (string name, uvm_component parent);
	super.new(name, parent);
endfunction : new

// Build Phase //
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))
	`uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
endfunction: build_phase

// Run Phase //
virtual task run_phase(uvm_phase phase)
    super.run_phase(phase);
    ram_seq_item req;
    forever begin
    seq_item_port.get_next_item(req);
    vif.transfer(req);
    if(req.valid_w_A == 1) begin 
        drive_write();
        vif.ready_w_A = 0;
        #10;
    end
    if(req.valid_r_A == 1) begin 
        drive_read();
        vif.ready_r_A = 0;
        #10;
    end
    seq_item_port.item_done();
    end
endtask: run_phase

// Drive Write::Task //
virtual task drive_write();
    @(posedge vif.aclk);
    vif.addr_A = req.addr_A;
    temp_0[i++]=req.addr_A;
    vif.valid_w_A = 1;
    wait(vif.ready_w_A == 1);
    @(posedge vif.aclk);
    @(posedge vif.aclk);
    vif.addr_valid_A == 1; 
endtask


endclass







`endif