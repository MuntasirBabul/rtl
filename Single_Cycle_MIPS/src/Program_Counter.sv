module Program_Counter #
(
    parameter WIDTH = 32
)
(
    input   logic               CLK,
    input   logic               RST,
    input   logic   [WIDTH-1:0] PC_in,
    output  logic   [WIDTH-1:0] PC
);

always @(posedge CLK or negedge RST) begin 
    if(!RST)
        PC <= 'b0;
    else 
        PC <= PC_in;
end
endmodule