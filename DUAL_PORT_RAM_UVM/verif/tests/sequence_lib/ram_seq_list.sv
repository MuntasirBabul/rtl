`ifndef AXI_SEQ_LIST 
`define AXI_SEQ_LIST

package axi_seq_list;

import uvm_pkg::*;
`include "uvm_macros.svh"

import axi_agent_pkg::*;
import axi_env_pkg::*;

`include "ram_sequence_0.sv"
`include "ram_sequence_1.sv"
endpackage

`endif