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

    logic [BUS_WIDTH-1:0] data_in_A,    // BUS_IN                     > port A
    logic [BUS_WIDTH-1:0] data_in_B,    // BUS_IN                     > port B
    logic [BUS_WIDTH-1:0] data_out_A,   // BUS_OUT                    > port A
    logic [BUS_WIDTH-1:0] data_out_B,   // BUS_OUT                    > port B

    logic [ADDR_WIDTH-1:0] addr_A,      // ADDRESS                    > port A
    logic [ADDR_WIDTH-1:0] addr_B,      // ADDRESS                    > port B

    bit ready_r_A,                      // READY::READ                > port A
    bit valid_r_A,                      // VALID::READ                > port A
    bit ready_w_A,                      // READY::WRITE               > port A
    bit valid_w_A,                      // VALID::WRITE               > port A

    bit ready_r_B,                      // READY::READ                > port B
    bit valid_r_B,                      // VALID::READ                > port B
    bit ready_w_B,                      // READY::WRITE               > port B
    bit valid_w_B,                      // VALID::WRITE               > port B

    bit addr_ready_A,                   // READY::ADDRESS             > port A
    bit addr_valid_A,                   // VALID::ADDRESS             > port A
    bit addr_ready_B,                   // READY::ADDRESS             > port B
    bit addr_valid_B,                   // VALID::ADDRESS             > port B

    bit we_A,                           // WRITE_ENABLE               > port A
    bit we_B,                           // WRITE_ENABLE               > port B
    bit en                              // ASYNC_ENABLE and SYNC_WRITE_ENABLE

modport DUT
(
    input   logic aclk,                                   

    input   logic [BUS_WIDTH-1:0] data_in_A,                                           
    input   logic [BUS_WIDTH-1:0] data_in_B,                                            
    output  logic [BUS_WIDTH-1:0] data_out_A,                                         
    output  logic [BUS_WIDTH-1:0] data_out_B,                                         

    input   logic [ADDR_WIDTH-1:0] addr_A,                                             
    input   logic [ADDR_WIDTH-1:0] addr_B,                                            

    input   bit ready_r_A,                                                                
    output  bit valid_r_A,                                                            
    output  bit ready_w_A,                                                            
    input   bit valid_w_A,                                                            

    input   bit ready_r_B,                                                                
    output  bit valid_r_B,                                                             
    output  bit ready_w_B,                                                             
    input   bit valid_w_B,                                                            

    output  bit addr_ready_A,                                                         
    input   bit addr_valid_A,                                                         
    output  bit addr_ready_B,                                                         
    input   bit addr_valid_B,                                                         

    input   bit we_A,                                                                 
    input   bit we_B,                                                                 
    input   bit en                                                                     
);
modport monitor
(
    input   logic aclk,                                  

    input   logic [BUS_WIDTH-1:0] data_in_A,                                          
    input   logic [BUS_WIDTH-1:0] data_in_B,                                          
    input   logic [BUS_WIDTH-1:0] data_out_A,                                         
    input   logic [BUS_WIDTH-1:0] data_out_B,                                         

    input   logic [ADDR_WIDTH-1:0] addr_A,
    input   logic [ADDR_WIDTH-1:0] addr_B,

    input   bit ready_r_A,
    input   bit valid_r_A,
    input   bit ready_w_A,
    input   bit valid_w_A,
	
	input   bit ready_r_B,
    input   bit valid_r_B,
    input   bit ready_w_B,
    input   bit valid_w_B,

    input   bit addr_ready_A,
    input   bit addr_valid_A,
    input   bit addr_ready_B,
    input   bit addr_valid_B,

    input   bit we_A,
    input   bit we_B,
    input   bit en
);
modport driver_0
(
	input   logic aclk,
	output  logic [BUS_WIDTH-1:0] data_in_A,
	input   logic [BUS_WIDTH-1:0] data_out_A,
	output  logic [ADDR_WIDTH-1:0] addr_A,
	
	output  bit ready_r_A,
	input   bit valid_r_A,
	input   bit ready_w_A,
	output  bit valid_w_A,
	
	input   bit addr_ready_A,
	output  bit addr_valid_A,
	output  bit we_A,
	output  bit en
);
modport driver_1
(
    input   logic aclk,
    output  logic [BUS_WIDTH-1:0] data_in_B,
    input   logic [BUS_WIDTH-1:0] data_out_B,
    output  logic [ADDR_WIDTH-1:0] addr_B,

    output  bit ready_r_B,
    input   bit valid_r_B,
    input   bit ready_w_B,
    output  bit valid_w_B,

    input   bit addr_ready_B,
    output  bit addr_valid_B,
    output  bit we_B,
    output  bit en
);

endinterface

`endif
