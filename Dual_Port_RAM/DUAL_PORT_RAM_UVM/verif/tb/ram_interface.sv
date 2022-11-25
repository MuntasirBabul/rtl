`ifndef RAM_INTERFACE
`define RAM_INTERFACE
	
interface ram_if #
(
    parameter   ADDR_WIDTH = 32,
                BUS_WIDTH  = 64
)
(
    input logic aclk, aresetn	
);

    logic [BUS_WIDTH-1:0] data_in_A;    // BUS_IN                     > port A
    logic [BUS_WIDTH-1:0] data_in_B;    // BUS_IN                     > port B
    logic [BUS_WIDTH-1:0] data_out_A;   // BUS_OUT                    > port A
    logic [BUS_WIDTH-1:0] data_out_B;   // BUS_OUT                    > port B

    logic [ADDR_WIDTH-1:0] addr_A;      // ADDRESS                    > port A
    logic [ADDR_WIDTH-1:0] addr_B;      // ADDRESS                    > port B

    bit ready_r_A;                      // READY::READ                > port A
    bit valid_r_A;                      // VALID::READ                > port A
    bit ready_w_A;                      // READY::WRITE               > port A
    bit valid_w_A;                      // VALID::WRITE               > port A

    bit ready_r_B;                      // READY::READ                > port B
    bit valid_r_B;                      // VALID::READ                > port B
    bit ready_w_B;                      // READY::WRITE               > port B
    bit valid_w_B;                      // VALID::WRITE               > port B

    bit addr_ready_A;                   // READY::ADDRESS             > port A
    bit addr_valid_A;                   // VALID::ADDRESS             > port A
    bit addr_ready_B;                   // READY::ADDRESS             > port B
    bit addr_valid_B;                   // VALID::ADDRESS             > port B

    bit we_A;                           // WRITE_ENABLE               > port A
    bit we_B;                           // WRITE_ENABLE               > port B
    bit en                              // ASYNC_ENABLE and SYNC_WRITE_ENABLE

modport DUT
(
    input    aclk,                                   

    input    data_in_A,                                           
    input    data_in_B,                                            
    output   data_out_A,                                         
    output   data_out_B,                                         

    input    addr_A,                                             
    input    addr_B,                                            

    input    ready_r_A,                                                                
    output   valid_r_A,                                                            
    output   ready_w_A,                                                            
    input    valid_w_A,

	input    ready_r_B,                                                                
    output   valid_r_B,                                                             
    output   ready_w_B,                                                             
    input    valid_w_B,                                                            

    output   addr_ready_A,                                                         
    input    addr_valid_A,                                                         
    output   addr_ready_B,                                                         
    input    addr_valid_B,                                                         

    input    we_A,                                                                 
    input    we_B,                                                                 
    input    en                                                                     
);
modport monitor
(
    input    aclk,                                  

    input    data_in_A,                                          
    input    data_in_B,                                          
    input    data_out_A,                                         
    input    data_out_B,                                         

    input    addr_A,
    input    addr_B,

    input    ready_r_A,
    input    valid_r_A,
    input    ready_w_A,
    input    valid_w_A,
	
	input    ready_r_B,
    input    valid_r_B,
    input    ready_w_B,
    input    valid_w_B,

    input    addr_ready_A,
    input    addr_valid_A,
    input    addr_ready_B,
    input    addr_valid_B,

    input    we_A,
    input    we_B,
    input    en
);
modport driver_0
(	
	input    aclk,
	output   data_in_A,
	input    data_out_A,
	output   addr_A,
	
	output   ready_r_A,
	input    valid_r_A,
	input    ready_w_A,
	output   valid_w_A,
	
	input    addr_ready_A,
	output   addr_valid_A,
	output   we_A,
	output   en
);
modport driver_1
(
    input    aclk,
    output   data_in_B,
    input    data_out_B,
    output   addr_B,

    output   ready_r_B,
    input    valid_r_B,
    input    ready_w_B,
    output   valid_w_B,

    input    addr_ready_B,
    output   addr_valid_B,
    output   we_B,
    output   en
);

endinterface

`endif
