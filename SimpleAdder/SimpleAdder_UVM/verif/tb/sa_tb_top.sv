`ifndef SA_TB_TOP
`define SA_TB_TOP

module sa_tb_top;
import uvm_pkg::*;

// clock
parameter = 10
bit clk

initial begin 
clk = 0;
forever #(cycle/2) clk = ~clk;
end


// declare interface
sa_if vif(clk);

// Connect vif to DUT
simple_adder DUT(
    .clk(vif.clk),
    .ina(vif.sig_ina),
    .inb(vif.sig_inb),
    .en_i(vif.sig_en_i),
    .out(vif.sig_out),
    .en_o(vif.sig_en_o));

initial begin 
    uvm_resource_db#(virtual sa_if)::set(uvm_root::get(),"*","vif",vif)
end

// run test 
initial begin 
run_test();
end



`endif