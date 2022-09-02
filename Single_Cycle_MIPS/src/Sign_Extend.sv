module Sign_Extend #
(
	parameter	WIDTH = 32,
				IMMEDIATE_BITS =16
)
(
	input  logic [IMMEDIATE_BITS-1:0]	Immediate,
	output logic [WIDTH-1:0]			SignImm
);

assign SignImm = { {16{Immediate[IMMEDIATE_BITS-1]}}, Immediate[IMMEDIATE_BITS-1]};

endmodule
