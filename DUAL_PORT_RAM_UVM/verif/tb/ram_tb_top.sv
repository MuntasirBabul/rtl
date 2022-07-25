`ifndef RAM_TB_TOP
`define RAM_TB_TOP

`include "uvm_macors.svh"
`include "ram_interface.sv"

import uvm_pkg::*;

module ram_tb_top;

	import ram_test_list::*;
	parameter cycle = 10;
	 aclk;
	 aresetn;

// clock //
initial begin 
aclk = 0;
forever #(cycle/2) aclk = ~aclk;
end

// reset //
initial begin
aresetn = 1;
#(cycle* 5) aresetn =0;  //10*5= 50 cycle...will reset after 50 cycle
end

// interface //
ram_if intf 
(
	aclk,
	aresentn
);

// DUT //
dual_port_ram_64 dut_ram
(
	.aclk(intf.aclk),                                    

    .data_in_A(intf.data_in_A),                                            
    .data_in_B(intf.data_in_B),                                           
    .data_out_A(intf.data_out_A),                                          
    .data_out_B(intf.data_out_B),                                         

    .addr_A(intf.addr_A),                                              
    .addr_B(intf.addr_B),                                                           

    .ready_r_A(intf.ready_r_A),                                                                
    .valid_r_A(intf.valid_r_A),                     
    .ready_w_A(intf.ready_w_A),                    
    .valid_w_A(intf.valid_w_A),                    

    .ready_r_B(intf.ready_r_B),                      
    .valid_r_B(intf.valid_r_B),                       
	.ready_w_B(intf.ready_w_B),           
	.valid_w_B(intf.valid_w_B),              

    .addr_ready_A(intf.addr_ready_A),           
    .addr_valid_A(intf.addr_valid_A),           
    .addr_ready_B(intf.addr_ready_B),           
    .addr_valid_B(intf.addr_valid_B),           

    .we_A(intf.we_A),                   
    .we_B(intf.we_B),                   
    .en(intf.en)                      
);

// run_test //
initial begin 
	run_test();
end

// virtual interface //
initial begin 
	uvm_config_db #(virtual ram_if)::set(uvm_root::get(),"*","vif",intf);
end

endmodule
`endif
