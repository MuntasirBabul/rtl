`ifndef RAM_ENV_PKG
`define RAM_ENV_PKG

package ram_env_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import ram_agent_pkg::*;

	`include "ram_coverage.sv"
	`include "ram_scoreboard.sv"
	`include "ram_environment.sv"

endpackage

`endif
