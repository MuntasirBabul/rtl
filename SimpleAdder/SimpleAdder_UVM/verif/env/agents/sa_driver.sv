`ifndef SA_DRIVER
`define SA_DRIVER

class sa_driver extends uvm_driver#(sa_transaction);
    `uvm_component_utils(sa_driver)
    virtual sa_if vif;

    function new(string name, uvm_component parent);
        super.new(new, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual sa_if)::get(this, "", "vif", vif))
        `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        drive();
    endtask: run_phase

    virtual task drive();
        sa_transaction sa_tx;
        integer counter = 0, state = 0;
        vif.sig_ina = 0'b0;
        vif.sig_inb = 0'b0;
        vif.sig_en_i = 1'b0;

        forever begin 
            if(counter == 0) begin 
                seq_item_port.get_next_item(sa_tx);
                `uvm_info("sa_driver", sa_tx.sprint(), UVM_LOW);
            end 
            @(posedge vif.clk)
            begin 
                if(counter == 0)
                begin 
                    vif.sig_en_i = 1'b1;
                    state = 1;
                end

                if(counter == 1)
                begin 
                    vif.sig_en_i = 1'b0;
                end

                case(state)
                1: begin 
                    vif.sig_ina = sa_tx.ina[1];
                    vif.sig_inb = sa_tx.inb[1];

                    sa_tx.ina = sa_tx.ina << 1;
                    sa_tx.inb = sa_tx.inb << 1;

                    counter = counter + 1;
                    if(counter == 2) state = 2;
                end 
                2: begin 
                    vif.sig_ina = 1'b0;
                    vif.sig_inb = 1'b0;
                    counter = counter + 1;

                    if(counter==6) begin 
                        counter = 0;
                        state = 0;
                        seq_item_port.item_done();
                    end
                end 
            end
        end    
    endtask: drive
endclass
`endif