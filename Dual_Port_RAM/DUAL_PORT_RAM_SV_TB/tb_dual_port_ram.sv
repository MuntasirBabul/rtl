`timescale 1ns/1ps

module tb_dual_port_ram #
(   
    parameter
    BUS_WIDTH   = 64,
    ADDR_WIDTH  = 32,
    CYCLE       = 20
)
();

logic clk;
logic [BUS_WIDTH-1:0] data_in_A;    
logic [BUS_WIDTH-1:0] data_in_B;    
logic [BUS_WIDTH-1:0] data_out_A;   
logic [BUS_WIDTH-1:0] data_out_B;   

logic [ADDR_WIDTH-1:0] addr_A;      
logic [ADDR_WIDTH-1:0] addr_B;      

logic ready_r_A;                    
logic valid_r_A;                    
logic ready_w_A;                    
logic valid_w_A;                    

logic ready_r_B;                      
logic valid_r_B;                      
logic ready_w_B;                      
logic valid_w_B;                      

logic addr_ready_A;                   
logic addr_valid_A;                   
logic addr_ready_B;                   
logic addr_valid_B;                   

logic we_A;                           
logic we_B;                           
logic en;              
event ready_edge_A, ready_edge_B, clk_edge;

dual_port_ram_64bit DUT
(
.clk            (clk            ),
.data_in_A      (data_in_A      ),
.data_out_A     (data_out_A     ),
.data_in_B      (data_in_B      ),
.data_out_B     (data_out_B     ),
.addr_A         (addr_A         ),
.addr_B         (addr_B         ),
.ready_r_A      (ready_r_A      ),
.valid_r_A      (valid_r_A      ),
.ready_r_B      (ready_r_B      ),
.valid_r_B      (valid_r_B      ),
.ready_w_A      (ready_w_A      ),
.valid_w_A      (valid_w_A      ),
.ready_w_B      (ready_w_B      ),
.valid_w_B      (valid_w_B      ),
.addr_ready_A   (addr_ready_A   ),
.addr_valid_A   (addr_valid_A   ),
.addr_ready_B   (addr_ready_B   ),
.addr_valid_B   (addr_valid_B   ),
.we_A           (we_A           ),
.we_B           (we_B           ),
.en             (en             )
);
         
                   
class addr_data_gen;
    rand bit [31:0] data;
    rand integer addr;
    bit [31:0]temp[0:9];
    integer i = 0;
    constraint data_addr_condition {
        addr <= 429496729;
        data <= 64'hFFFF_FFFF_FFFF_FFFF;
    }
	
    function void post_randomize();
         temp[i++]=addr;
    endfunction
      
    function assignValueA;
      addr_A= addr;
      data_in_A= data;
    endfunction
   
    function assignValueB;
      addr_B= addr;
      data_in_B= data;
    endfunction
endclass
                   

initial begin 
    clk = 1;
forever 
    #(CYCLE/2) clk = ~clk;   
end


always@(negedge ready_w_A) begin
    -> ready_edge_A;
    end

always@(posedge clk) begin
    -> clk_edge;
end

always@(negedge ready_w_B) begin
    -> ready_edge_B;
    end
  
initial begin 
  
    addr_data_gen test_A= new();
    addr_data_gen test_B= new();
    integer j=0;
    integer k=0;
    ready_r_A=1;
    ready_r_B=1;
  
    $timeformat(-9,1,"ns");
    $monitor("Addr_A=%h, Data_in_A=%h\n Addr_B=%h,Data_in_B=%h,time= %t\n",addr_A,data_in_A, addr_B, data_in_B,$time);
   
    en = 1; we_A = 1; we_B = 1;
    valid_w_A       = 1;
    addr_valid_A    = 1;
    valid_w_B       = 1;
    addr_valid_B    = 1;
    
   
fork 
    repeat(9) begin
    @(clk_edge.triggered);
    test_A.randomize() with {
        addr>8000;
    };
    
    test_A.assignValueA();
    @(ready_edge_A.triggered);
    end
    
    repeat(9) begin
    @(clk_edge.triggered);   
    test_B.randomize() with {
        addr>8000;
    };
    
    test_B.assignValueB();
    @(ready_edge_A.triggered);
    end
join
    
    addr_valid_A=1;
    data_in_A='z;
    addr_A='z;
    valid_w_A=0;
    we_A=0;
    
    addr_valid_B=1;
    data_in_B='z;
    addr_B='z;
    valid_w_B=0;
    we_B=0;
    
    #1;
    
    $monitor("addrA = %h, data_out_A = %h\t, addrB = %h, data_out_B = %h, time = %0t\n", addr_A, data_out_A, addr_B, data_out_B, $time);
  
fork
    repeat(9)begin
    addr_A=test_A.temp[j++];
    #1;
    end
   
    repeat(9)begin
    addr_B=test_B.temp[k++];
    #1;
    end      
join
    
    addr_valid_A=0;
    addr_valid_B=0;
    #10;
    $finish;
end
endmodule