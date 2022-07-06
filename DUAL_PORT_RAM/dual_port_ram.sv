module dual_port_ram_64bit #
(
    parameter   ADDR_WIDTH = 32, 
                BUS_WIDTH = 64
)
(
    input logic clk,                            // CLOCK

    input   logic [BUS_WIDTH-1:0] data_in_A,    // BUS_IN                    > port A
    input   logic [BUS_WIDTH-1:0] data_in_B,    // BUS_IN                    > port B
    output  logic [BUS_WIDTH-1:0] data_out_A,   // BUS_OUT                   > port A
    output  logic [BUS_WIDTH-1:0] data_out_B,   // BUS_OUT                   > port B

    input   logic [ADDR_WIDTH-1:0] addr_A,      // ADDRESS                    > port A
    input   logic [ADDR_WIDTH-1:0] addr_B,      // ADDRESS                    > port B

    input   bit ready_r_A,                      // READY/READ                 > port A    
    output  bit valid_r_A,                      // VALID/READ                 > port A
    output  bit ready_w_A,                      // READY/WRITE                > port A
    input   bit valid_w_A,                      // VALID/WRITE                > port A

    input   bit ready_r_B,                      // READY/READ                 > port B    
    output  bit valid_r_B,                      // VALID/READ                 > port B
    output  bit ready_w_B,                      // READY/WRITE                > port B
    input   bit valid_w_B,                      // VALID/WRITE                > port B
    
    output  bit addr_ready_A = 1,               // READY/ADDRESS              > port A
    input   bit addr_valid_A,                   // VALID/ADDRESS              > port A
    output  bit addr_ready_B = 1,               // READY/ADDRESS              > port B
    input   bit addr_valid_B,                   // VALID/ADDRESS              > port B

    input   bit we_A,                           // WRITE_ENABLE               > port A
    input   bit we_B,                           // WRITE_ENABLE               > port B
    input   bit en                              // ASYNC_ENABLE and SYNC_WRITE_ENABLE
);

logic [BUS_WIDTH-1:0] mem[0:429496729];         // MEMORY

/////////////////////////////////////////////////
/////////// ADDRESS TRANSFER > port A ///////////
/////////////////////////////////////////////////

always_ff @(posedge clk) begin
    if(en && !addr_ready_A) begin
        addr_ready_A <= 1;
    end
    else if(en && addr_ready_A && addr_valid_A) begin
        addr_ready_A <= 0;
    end
end
/////////////////////////////////////////////////
/////////// ADDRESS TRANSFER > port B ///////////
/////////////////////////////////////////////////

always_ff @(posedge clk) begin
    if(en && !addr_ready_B) begin
        addr_ready_B <= 1;
    end
    else if(en && addr_ready_B && addr_valid_B) begin
        addr_ready_B <= 0;
    end
end
/////////////////////////////////////////////////
////////// WRITE TRANSACTION > port A ///////////
/////////////////////////////////////////////////

always_ff @(posedge clk) begin: mem_write_A
    if(en && we_A && !ready_w_A) begin  
        ready_w_A   <= 1;
	end
    else if(en && we_A && addr_valid_A && addr_ready_A && ready_w_A && valid_w_A && (|addr_A[ADDR_WIDTH-1:13])) begin
        mem[addr_A] <= data_in_A;
        ready_w_A   <= 0;
    end
end    
/////////////////////////////////////////////////
////////// WRITE TRANSACTION > port B ///////////
/////////////////////////////////////////////////            

always_ff @(posedge clk) begin: mem_write_B
    if(en && we_B && !ready_w_B ) begin
        ready_w_B   <= 1;
    end
    else if(en && we_B && addr_valid_B && addr_ready_B && ready_w_B && valid_w_B && (|addr_B[ADDR_WIDTH-1:13])) begin
        mem[addr_B] <= data_in_B;
        ready_w_B   <= 0;
    end
end               
/////////////////////////////////////////////////
/////////// READ TRANSACTION > port A ///////////
/////////////////////////////////////////////////
    
always_ff @(posedge clk) begin: mem_read_A
    if(en && !addr_valid_A && valid_r_A) begin
        valid_r_A   <= 0;
    end
    else if(en && addr_valid_A) begin     	     
        data_out_A  <= mem[addr_A];
        valid_r_A   <= 1;
    end
        
end
/////////////////////////////////////////////////
/////////// READ TRANSACTION > port B ///////////
/////////////////////////////////////////////////
    
always_ff @(posedge clk) begin: mem_read_B
    if(en && !addr_valid_B && valid_r_B) begin
        valid_r_B   <= 0;
    end
    else if(en && addr_valid_B) begin
        valid_r_B   <= 1;
        data_out_B  <= mem[addr_B];
    end       
end

endmodule

