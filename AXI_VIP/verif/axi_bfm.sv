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
        drive_tx(tx); // drive the tx
    end
endtask

task drive_tx(axi_tx tx);
    case(tx.wr_rd)
        1: begin // WRITE_TX
            write_address_phase(tx);
            write_data_phase(tx);
            write_response_phase(tx);
        end
        2: begin // READ_TX 
            read_address_phase(tx);
            read_data_phase(tx);
        end
    endcase
endtask

task write_address_phase(axi_tx tx); 
    $display("#####_____ Initiate write address phase _____#####");
endtask

task write_data_phase(axi_tx tx); 
    $display("#####_____ Initiate write data phase _____#####");
endtask

task write_response_phase(axi_tx tx); 
    $display("#####_____ Initiate write response phase _____#####");
endtask

task read_address_phase(axi_tx tx); 
    $display("#####_____ Initiate read address phase _____#####");
endtask

task read_data_phase(axi_tx tx); 
    $display("#####_____ Initiate read data phase _____#####");
endtask

endclass