// axi_bfm.sv
// instantiate axi_tx
// run task > get the tx from mailbox >> print tx
// implement task fro drive_tx

// task drive_tx
// implement case for write_tx, read_tx logic
// for write_tx 
// case(tx.wr_rd) >> 1: implement task for write_address_phase, write_data_phase & write response phase >> $display
//                >> 0: implement task for read_address phase, read_data phase                          >> $display

class axi_bfm;
axi_tx tx;

task run();
    $display("#####_____ axi_bfm _____#####");
    forever begin 
        axi_common::gen2bfm.get(tx); // get the tx from bfm
        tx.print("axi_bfm");
        drive.tx(); // drive the tx
    end
endtask
endclass