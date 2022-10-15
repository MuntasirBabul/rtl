`ifndef SA_INTERFACE
`define SA_INTERFACE

interface sa_if #
(
    parameter BUS_WITDH = 4
)
(
    input logic clk;
)
logic [BUS_WIDTH-1:0] sig_ina;
logic [BUS_WIDTH-1:0] sig_inb;
logic sig_en_i;
logic [BUS_WIDTH-1:0] sig_out;
logic sig_en_o;

modport DUT(input clk, input sig_ina, input sig_inb, input sig_en_i, output sig_out, output sig_en_o);
modport driver(output clk, output sig_ina, output sig_inb, output sig_en_i, input sig_out, input sig_en_o);
modport monitor(input clk, input sig_ina, input sig_inb, input sig_en_i, output sig_out, output sig_en_o);

endinterface
`endif