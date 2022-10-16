`ifndef SA_MONITOR
`define SA_MONITOR

class sa_monitor_before extends uvm_monitor;
    uvm_component_utils(sa_monitor_before)
    uvm_analysis_port#(sa_transaction) mon_ap_before;
    virtual sa_if vif;

    function new(string name, uvm_component parent);
        super.new(naem,parent);
    endfunction: new

    function void build_phase(uvm_phase phase); // construct 
        super.build_phase(phase);
        if(!uvm_config_db#(virtual vif)::get(this, "", "vif", vif))
        `uvm_fatal("NO VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        mon_ap_before = new(.name("mon_ap_before"), .parent(this));
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        integer counter_mon = 0, state = 0;
        sa_transaction sa_tx;
        sa_tx = sa_transaction::type_id::create(.name(sa_tx), .contxt(get_full_name()));

        forever begin 
            @(posedge vif.clk) begin 
                if(vif.sig_en_o == 1'b1)
                    state = 3;
                if(state = 3) begin 
                    sa_tx.out = sa_tx.out << 1;
                    sa_tx.out = vif.sig_out;

                    counter_mon = counter_mon + 1;

                    if(counter_mon = 3) begin 
                        state = 0;
                        counter_mon = 0;

                        mon_ap_before.write(sa_tx);
                    end 
                end
            end
        end
    endtask: run_phase
endclass: sa_monitor_before

class sa_monitor_after extends uvm_monitor;
    `uvm_component_utils(sa_monitor_after)
    uvm_analysis_port#(sa_transaction) mon_ap_after;
    virtual sa_if vif;
    sa_transaction sa_tx;
    sa_transaction sa_tx_cg; // for coverage
    
    covergroup sa_cg; // define coverpoint
        ina_cp: coverpoint sa_tx_cg.ina;
        inb_cp: coverpoint sa_tx_cg.inb;
        cross ina_cp, inb_cp;
    endgroup: sa_cg

    function new(string name, uvm_component parent);
        super.new(name, parent);
        sa_cg = new;
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual vif)::get(this, "", "vif", vif))
        `uvm_fatal("NO VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});    
        mon_ap_after = new(.name("mon_ap_after"), .parent(this));
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        integer counter_mon = 0, state = 0;
        sa_tx = sa_transaction::type_id::create(.name(sa_tx), .contxt(this));

        forever begin 
            @(posedge vif.clk) begin
                if(vif.sig_en_i == 1'b1) begin 
                    state = 1;
                    sa_tx.ina = 4'b0000;
                    sa_tx.inb = 4'b0000;
                    sa_tx.out = 5'b00000;
                end 

                if(state==1) begin 
                    sa_tx.ina = sa_tx.ina << 1;
                    sa_tx.inb = sa_tx.inb << 1;

                    sa_tx.ina[0] = vif.sig_ina;
                    sa_tx.inb[0] = vif.sig_inb;

                    counter_mon = counter_mon + 1;

                    if(counter == 2) begin 
                        state = 0;
                        counter_mon = 0;

                        predictor(); // precdict the result
                        sa_tx_cg = sa_tx;
                        sa_cg.sample(); // sample coverage
                        mon_ap_after.write(sa_tx) // send tx to analysis port
                    end 
                end
            end
        end
    endtask: run_phase
endclass : sa_monitor_after
`endif