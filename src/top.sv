

`include "interface.sv"
`include "axi4_lite_slave.sv"
`include "axi_pkg.sv"
module top;
	 import uvm_pkg::*;
	 import axi_pkg::*;
	 bit clk,reset;
	 inf vif(clk,reset);
	 axi4_lite_slave dut(.ACLK(clk),.ARESETn(reset),.AWADDR(vif.AWADDR),.AWPROT(vif.AWPROT),.AWVALID(vif.AWVALID),.AWREADY(vif.AWREADY),.WDATA(vif.WDATA),.WSTRB(vif.WSTRB),.WVALID(vif.WVALID),.WREADY(vif.WREADY),.BRESP(vif.BRESP),.BVALID(vif.BVALID),.BREADY(vif.BREADY),.ARADDR(vif.ARADDR),.ARPROT(vif.ARPROT),.ARVALID(vif.ARVALID),.ARREADY(vif.ARREADY),.RDATA(vif.RDATA),.RRESP(vif.RRESP),.RVALID(vif.RVALID),.RREADY(vif.RREADY));
	 initial begin
		   forever #5 clk=~clk;
		  end
	 initial begin
		   reset=0;
		   repeat(2)@(posedge clk);
		   reset=1;
		  end
	 initial begin
		   uvm_config_db#(virtual inf)::set(null,"","vif",vif);
		   
		  run_test("test");
		  end
endmodule
