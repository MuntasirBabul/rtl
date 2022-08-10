// axi_env.sv component
// instantiate axi_bfm, axi_gen, axi_mon, axi_cov
// in the run task of env print "run task of env"


class axi_env;

axi_gen gen;
axi_bfm bfm;
axi_mon mon;
axi_cov cov;

function new();
    gen = new();
    bfm = new();
    mon = new();
    cov = new();
endfunction

task  run();
    $display("#####_______ Running ENV Task _______#####");

    fork 
        gen.run();
        bfm.run();
        mon.run();
        cov.run();
    join

endtask
endclass