// axi_gen.sv components
// instantiate axi_tx as tx
// in run task of gen print "run task of gen" 
// randomize, print and put to mailbox > tx

class axi_gen;

axi_tx tx;

task run();
    $display("#####_____ Running axi_gen _____#####");
    tx = new();
    tx.randomize();
    tx.print("axi_gen");
    axi_common::gen2bfm.put();
endtask



endclass