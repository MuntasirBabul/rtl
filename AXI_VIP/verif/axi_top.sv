// axi_top.sv componenet
// * clk, rst declaration & generation
// * interface, dut, env instantiation
// * call run task of env
// * assertion module declaration
// * logic to decide when to end the simulation 

// what is interface? what is the need for interface in TB development
// Sending bundle of data, dynamic(TB) to static(DUT)  > interface, for assertions, scoreboard implementations for driving and sampling signals,

module top;

reg rst, clk;

axi_interface pif(clk,rst);

axi_slave dut();
axi_env env();
axi_assertion axi_assertion_i();
initial begin 
    clk = 0;
    forever #5 clk = ~clk;
end 

initial begin 

rst = 1;
repeat(2) @(posedge clk);
rst = 0;
env = new();
env.run();
end  

initial begin 
    #1000
    finish();
end


endmodule