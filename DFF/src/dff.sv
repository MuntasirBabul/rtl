module DFF
(
	input logic d,
	input logic a_rst,
	input logic clk,
	output logic q
);

always@(posedge clk or negedge a_rst)
	if(!a_rst)
		q <= 0;
	else q <= d;

endmodule
