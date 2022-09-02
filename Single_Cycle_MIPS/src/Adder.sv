module Adder #
(
    parameter WIDTH = 32
)
(
    input logic [WIDTH-1:0]     A,
    input logic [WIDTH-1:0]     B,
    output logic [WIDTH-1:0]    C
)

assign C = A + B;

endmodule