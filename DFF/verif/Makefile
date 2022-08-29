DUT = DFF

TOPLEVEL_LANG ?=verilog

PWD=$(shell pwd)

VERILOG_SOURCES = $(PWD)/../src/dff.sv
TOPLEVEL := DFF
MODULE   := pytests.test_dff_cov

include $(shell cocotb-config --makefiles)/Makefile.sim
