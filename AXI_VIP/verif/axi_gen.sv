// axi_gen.sv components
// instantiate axi_tx as tx
// in run task of gen print "run task of gen" 
// randomize, print and put to mailbox > tx

class axi_gen;

axi_tx tx;

task run();
    $display("#####_____ Running axi_gen _____#####");
    tx = new();
    tx.randomize() with {tx.wr_rd == 1};
    tx.print("axi_gen_WRITE");
    axi_common::gen2bfm.put(tx);

    tx = new();
    tx.randomize() with {tx.wr_rd == 0};
    tx.print("axi_gen_READ");
    axi_common::gen2bfm.put(tx);
endtask
endclass