`ifndef SA_SEQUENCE
`define SA_SEQUENCE

class sa_sequence extends uvm_sequence(sa_transaction);
    `uvm_object_utils(sa_sequence)

    function new(string name = "");
        super.new(name);
    endfunction: new

    task body();
        sa_transaction sa_tx;
        repeat(15) begin 
            sa_tx = sa_transaction::type_id::create(.name("sa_tx"), .contxt(get_full_name()));
            start_item(sa_tx);
            assert(sa_tx.randomize());
            finish_item(sa_tx);
        end 
    endtask: body
endclass: sa_sequence


`endif