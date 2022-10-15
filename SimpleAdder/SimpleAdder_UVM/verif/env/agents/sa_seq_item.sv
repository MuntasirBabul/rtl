`ifndef SA_SEQUENCER
`define SA_SEQUENCER
`include "uvm_macros.svh"
import uvm_pkg::*;

class sa_transaction #(parameter BUS_WIDTH=4) extends uvm_sequence_item;
    rand bit [BUS_WIDTH-1:0] ina;
    rand bit [BUS_WIDTH-1:0] inb;
    bit      [BUS_WIDTH:0]   out;

    function new(string name = "");
        super.new(name);
    endfunction: new

    `uvm_object_utils_begin(sa_transaction)
        `uvm_field_int(ina, UVM_ALL_ON)
        `uvm_field_int(inb, UVM_ALL_ON)
        `uvm_field_int(out, UVM_ALL_ON)
    `uvm_object_utils_end 
endclass: sa_transaction

`endif