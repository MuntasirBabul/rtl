module MUX #
(
    parameter WIDTH = 32
)
(
    input  logic [WIDTH-1:0]    in1,
    input  logic [WIDTH-1:0]    in2,
    input  logic                sel,
    output logic [WIDTH-1:0]    out
);

always@(*) begin 
    out = sel? in1 : in2;
end

endmodule