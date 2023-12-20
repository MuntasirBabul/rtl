module dut (clk, reset, count);

input clk;
input reset;
output [3:0] count;

reg [3:0] counter;

always@(posedge clk)
    begin 
    if(~reset)
        counter <= 0;
    else 
        counter <= counter + 1;
    end

assign count = counter;

// dump vcd
initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1, dut);
end

endmodule
