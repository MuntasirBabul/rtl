import os
import cocotb
import cocotb_coverage
import pytest
import random
import numpy as np
from cocotb.clock import Clock
from cocotb.regression import TestFactory
from cocotb.triggers import Timer, RisingEdge, ReadOnly
from cocotb_coverage.coverage import *
from cocotb_coverage.crv import *

log = cocotb.logging.getLogger("cocotb.test")

NUM_TESTS = int(os.environ["NUM_TESTS"]) if ("NUM_TESTS" in os.environ) else 1

DFF_Coverage = coverage_section(CoverPoint("top.d", vname = "d", bins = (0,1))) 


# defined a sampling function named sample coverage
# Requirement: Must contain coverpoint > @DFF_Coverage. vname in covergroup must match with objects passed.

@DFF_Coverage
async def sample_coverage(dut, d): 
	await RisingEdge(dut.clk)
	dut.d.value = d



async def test_dff_cov(dut, NUM_TESTS):
	# Generating and Running clock
	clock = Clock(dut.clk, 2, units="ns")
	cocotb.fork(clock.start())
	await RisingEdge(dut.clk)
	

	
	for i in range(NUM_TESTS):
		df= random.randint(0,1) # generating random number
		await sample_coverage(dut, df) # call sampling function
	#assert dut.q == d, "Result Mismatched"
	
	# print coverage report
	# bins for printing
	coverage_db.report_coverage(log.info, bins=True)
	# export
	coverage_db.export_to_xml(filename="coverage_dff.xml")


tf = TestFactory(test_function = test_dff_cov)
tf.add_option("NUM_TESTS", list(range(NUM_TESTS)))
tf.generate_tests()

