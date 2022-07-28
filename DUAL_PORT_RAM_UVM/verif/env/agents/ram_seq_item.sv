`ifndef RAM_SEQ_ITEM
`define RAM_SEQ_ITEM
`include "uvm_macros.svh"
`import uvm_pkg::*;

class axi_seq_item #(parameter ADDR_WIDTH = 32, BUS_WIDTH  = 64) extends uvm_sequence_item;

    rand bit [BUS_WIDTH-1:0] data_in_A;    
    rand bit [BUS_WIDTH-1:0] data_in_B;    
    rand bit [ADDR_WIDTH-1:0] addr_A;      
    rand bit [ADDR_WIDTH-1:0] addr_B;      

    bit ready_r_A;                      
    bit valid_r_A;                      
    bit ready_w_A;                      
    bit valid_w_A;                      

    bit ready_r_B;                      
    bit valid_r_B;                      
    bit ready_w_B;                      
    bit valid_w_B;                      

    bit addr_ready_A;                   
    bit addr_valid_A;                   
    bit addr_ready_B;                   
    bit addr_valid_B;                   

    rand bit we_A;                           
    rand bit we_B;                           
    rand bit en;                              

// Constructor //
function new(string name = "ram_seq_item");
    super.new(name);
endfunction:new

// Utility and field macro //
`uvm_object_utils_begin(ram_seq_item)
    `uvm_field_int(addr_A,UVM_ALL_ON)
    `uvm_field_int(we_A,UVM_ALL_ON)
    `uvm_field_int(data_in_A,UVM_ALL_ON)
    `uvm_field_int(we_B,UVM_ALL_ON)
    `uvm_field_int(addr_B,UVM_ALL_ON)
    `uvm_field_int(data_in_B,UVM_ALL_ON)
`uvm_object_utils_end

// Constraint //
constraint global_
{
    addr_A < h'FFFF_FFFF;
    addr_B < h'FFFF_FFFF;
    if(en == 0) {
        we_A == 0;
        we_B == 0;
    }
}
endclass