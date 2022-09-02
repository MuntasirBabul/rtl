module shift_left_twice #
(
	parameter WIDTH = 32
)
(
	input  logic		[WIDTH-1:0]		in_data,
	output logic		[WIDTH-1:0]		out_data
);

assign out_data = (in_data<<2);

endmodule
