import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def basic_count(dut):
    # Generate clock
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())

    # Reset dut
    dut.reset.value = 0

    # Hold reset value for 2 cycles
    for i in range(2):
        await RisingEdge(dut.clk)
    dut.reset.value = 1

    # run for 50ns, with an assertion
    for i in range(50):
        await RisingEdge(dut.clk)
        dut_cnt = dut.count.value
        predicted_value = i % 16
        assert dut_cnt == predicted_value, "error %s != %s" % (str(dut.count.value), predicted_value)
