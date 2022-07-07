`timescale 1ns/1ps

module tb_dual_port_ram #
(   
    parameter
    BUS_WIDTH   = 64,
    ADDR_WIDTH  = 32,
    CYCLE       = 10
)
();

logic clk_t;
logic [BUS_WIDTH-1:0] data_in_A_t;    // BUS_IN                     > port A
logic [BUS_WIDTH-1:0] data_in_B_t;    // BUS_IN                     > port B
logic [BUS_WIDTH-1:0] data_out_A_t;   // BUS_OUT                    > port A
logic [BUS_WIDTH-1:0] data_out_B_t;   // BUS_OUT                    > port B

logic [ADDR_WIDTH-1:0] addr_A_t;      // ADDRESS                    > port A
logic [ADDR_WIDTH-1:0] addr_B_t;      // ADDRESS                    > port B

logic ready_r_A_t;                      // READY::READ                > port A    
logic valid_r_A_t;                      // VALID::READ                > port A
logic ready_w_A_t;                      // READY::WRITE               > port A
logic valid_w_A_t;                      // VALID::WRITE               > port A

logic ready_r_B_t;                      // READY::READ                > port B    
logic valid_r_B_t;                      // VALID::READ                > port B
logic ready_w_B_t;                      // READY::WRITE               > port B
logic valid_w_B_t;                      // VALID::WRITE               > port B

logic addr_ready_A_t;                   // READY::ADDRESS             > port A
logic addr_valid_A_t;                   // VALID::ADDRESS             > port A
logic addr_ready_B_t;                   // READY::ADDRESS             > port B
logic addr_valid_B_t;                   // VALID::ADDRESS             > port B

logic we_A_t;                           // WRITE_ENABLE               > port A
logic we_B_t;                           // WRITE_ENABLE               > port B
logic en_t;              
event ready_edge_A, ready_edge_B, clk_edge;

dual_port_ram_64bit DUT
(
.clk            (clk_t)         ,
.data_in_A      (data_in_A_t)   ,
.data_in_B      (data_in_B_t)   ,
.data_out_A     (data_out_A_t)  ,
.data_out_B     (data_out_B_t)  ,
.addr_A         (addr_A_t)      ,
.addr_B         (addr_B_t)      ,
.ready_r_A      (ready_r_A_t)   ,
.valid_r_A      (valid_r_A_t)   ,
.ready_r_B      (ready_r_B_t)   ,
.valid_r_B      (valid_r_B_t)   ,
.ready_w_A      (ready_w_A_t)   ,
.valid_w_A      (valid_w_A_t)   ,
.ready_w_B      (ready_w_B_t)   ,
.valid_w_B      (valid_w_B_t)   ,
.addr_ready_A   (addr_ready_A_t),
.addr_valid_A   (addr_valid_A_t),
.addr_ready_B   (addr_ready_B_t),
.addr_valid_B   (addr_valid_B_t),
.we_A           (we_A_t)        ,
.we_B           (we_B_t)        ,
.en             (en_t)
);

initial begin 
    clk_t = 0;
forever 
    #(CYCLE/2) clk_t = ~clk_t;   //5+5 
end

class addr_gen_data;
    rand bit [BUS_WIDTH-1:0] data;
    rand integer addr;
    bit [BUS_WIDTH-1:0] temp[0:9];
    integer i = 0;

    constraint data_addr_const{
        addr <= 429496729;
        data <= 64'hFFFF_FFFF_FFFF_FFFF;
    }

function void post_randomize();
    temp[i++] = addr;
endfunction

function void assign_port_A;
    addr_A_t    = addr;
    data_in_A_t = data;
endfunction

function void assign_port_B;
    addr_B_t    = addr;
    data_in_B_t = data;
endfunction
endclass

always@(negedge ready_w_A_t) begin
    -> ready_edge_A;
end

always@(negedge ready_w_B_t) begin
    -> ready_edge_B;
end

always@(posedge clk_t) begin
    -> clk_edge;
end

initial begin 
    addr_gen_data test_A = new();
    addr_gen_data test_B = new();
    integer j = 0;
    integer k = 0;
    ready_r_A_t = 1;
    ready_r_B_t = 1;
    valid_w_B_t = 1;
    addr_valid_B_t =1; 

#5

$monitor("addr A=%h, data_out_A=%h\t, addrB=%h, data_out_B=%h, time=%0t\n",addr_A_t,data_out_A_t,addr_B_t,data_out_B_t,$time);

fork
    repeat(10) begin 
        @(clk_edge.triggered);
        test_A.randomize() with { addr > 8000; };
        test_A.assign_port_A();
        @(ready_edge_A.triggered);
    end
    repeat(10) begin 
        @(clk_edge.triggered);
        test_B.randomize() with { addr > 8000; };
        test_B.assign_port_B();
        @(ready_edge_A.triggered);
    end
join

    addr_valid_A_t  = 1;
    data_in_A_t     = 'z;
    addr_A_t        = 'z;
    valid_w_A_t     = 0;
    we_A_t          = 0;

    addr_valid_B_t  = 1;
    data_in_B_t     = 'z;
    addr_B_t        = 'z;
    valid_w_B_t     = 0;
    we_B_t          = 0;

fork
    repeat(10) begin 
        addr_A_t = test_A.temp[j++];
        #5;
    end

    repeat(10) begin
        addr_B_t = test_B.temp[k++];
        #5;
    end
join

    addr_valid_A_t = 0;
    addr_valid_B_t = 0;
    #10;
    $finish;
end  
endmodule