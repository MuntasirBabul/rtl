import os
import random
import cocotb
import pytest
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge


@cocotb.test()
async def test_dff(dut):

	clock = Clock(dut.clk, 10, units = "us")
	cocotb.fork(clock.start())
	await FallingEdge(dut.clk)

	for i in range(10):
		val = random.randint(0,1)
		dut.d.value  = val
		await FallingEdge(dut.clk)
		assert dut.q.value == val, "Output was incorrect on the {}th cycle".format(i)
