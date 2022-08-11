// axi_tx.sv component
// declare signals > addr, dataq, len, wr_rd
// randomize the fields
// write constraint on dataq whose size should be len+1? why?
// write method to print tx

class axi_tx;
    rand bit[31:0]  addr;
    rand bit[31:0]  dataq[$];
    rand bit[3:0]   len;
    rand bit        wr_rd;

    // we have to write a constraint on size of data
    
constraint data_c{
    dataq.size() == len + 1;
}

function void print(string name = "axi_tx" );
    $display("\n#####_____\t%s\t______#####", name);
    $display("addr=%h",addr);
    $display("dataq=%p",dataq);
    $display("wr_rd=%h",wr_rd);
endfunction
endclass