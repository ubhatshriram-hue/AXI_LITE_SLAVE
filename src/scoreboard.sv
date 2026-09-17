

class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	uvm_tlm_analysis_fifo #(seq_item) inp_fifo;
	uvm_tlm_analysis_fifo #(seq_item) out_fifo;
	seq_item inp_tx;
	seq_item out_tx;
	seq_item exp; 

	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		inp_fifo=new("inp_fifo",this);
		out_fifo=new("out_fifo",this);
		exp=seq_item::type_id::create("exp");
	endfunction
	function void extract_phase(uvm_phase phase);
		  super.extract_phase(phase);
		 `uvm_info("RESULTS",$sformatf("PASS_COUNT=%d FAIL_COUNT=%0d ", success,fail),UVM_LOW) 
	endfunction
	task run_phase(uvm_phase phase);
		 forever begin
			   inp_fifo.get(inp_tx);
			   out_fifo.get(out_tx);
			   reference();
			  end
	endtask
	int success;
	int fail;
	reg [31:0]mem[16];
	bit [31:0]addr;
	bit [31:0] w_data;
	bit[3:0]wstrb;
	bit [31:0] r_data;
	bit waddr_done,wdata_done;
	bit [1:0]BRESP;
	bit BVALID;
	bit [1:0]RRESP;bit RVALID;


	task reference();
		`uvm_info("SCB",$sformatf("INP_TX-> reset=%b AWADDR=%d ,AWPROT=%b ,AWVALID=%b ,WDATA=%d ,WVALID=%b ,WSTRB=%b ,BREADY=%b ,ARADDR=%d ,ARPROT=%b ,ARVALID=%b ,RREADY=%b",
			               inp_tx.reset, inp_tx.AWADDR, inp_tx.AWPROT, inp_tx.AWVALID, inp_tx.WDATA, inp_tx.WVALID, inp_tx.WSTRB, inp_tx.BREADY, inp_tx.ARADDR, inp_tx.ARPROT, inp_tx.ARVALID, inp_tx.RREADY),UVM_NONE)
		`uvm_info("OUT_MON", $sformatf("OUT_TX -> AWREADY:%b | WREADY:%0b | BRESP:%0b | BVALID:%0b | ARREADY:%b | RDATA:%0d | RRESP:%0b | RVALID:%0b  ",
			      out_tx.AWREADY, out_tx.WREADY, out_tx.BRESP, out_tx.BVALID, out_tx.ARREADY, out_tx.RDATA, out_tx.RRESP, out_tx.RVALID), UVM_NONE)

		exp.RDATA=r_data;
		exp.RRESP=RRESP;
		exp.RVALID=RVALID;

		if(!inp_tx.reset)begin
			 r_data=0;
			  BRESP=0;BVALID=0;r_data=0; RRESP=0;RVALID=0;
			  foreach(mem[i])
				         mem[i]=0;
		end
		else
			 begin
				    if(RVALID)begin
					            RVALID=0; end
				    if(BVALID)begin
					             waddr_done=0;wdata_done=0;BVALID=0;BRESP=0;
					          end
				    if(inp_tx.AWVALID && out_tx.AWREADY)begin
					        waddr_done=1;
					        addr=inp_tx.AWADDR; end
				    if(inp_tx.WVALID && out_tx.WREADY)begin
					        wdata_done=1;
					        w_data=inp_tx.WDATA;
					        wstrb=inp_tx.WSTRB;  end
				    
				    if(waddr_done && wdata_done) begin
					         BVALID=1;
					         if(addr > 32'h40)
							        BRESP=2'b11;
					         else if(addr[1:0]!=2'b00 || (addr>=32'h28 && addr <=32'h30)  )
							         BRESP=2'b10;
					         else begin
							         BRESP=2'b00;
							         mem[addr>>2]={ {8{wstrb[3]}},{8{wstrb[2]}},{8{wstrb[1]}},{8{wstrb[0]}} }&w_data; 
							        end
					        end

				    if(inp_tx.ARVALID && out_tx.ARREADY)
					        begin
							     RVALID=1;
							     if(inp_tx.ARADDR > 32'h40)
								            RRESP=2'b11;
							     else if(inp_tx.ARADDR[1:0]!=2'b00  || (inp_tx.ARADDR>=32'h34 && inp_tx.ARADDR <=32'h38)  )
								            RRESP=2'b10;
							     else begin
								            RRESP=2'b00;
								            r_data=mem[inp_tx.ARADDR>>2];
								            end
							    end
				  
				  end
		 `uvm_info("SCB", $sformatf(
			       "EXP -> waddr_done=%b, wdata_done=%b, addr=%d, w_data=%d,  mem[addr]=%d | BRESP:%0b | BVALID:%0b |  RDATA:%0d | RRESP:%0b | RVALID:%0b  ",
			        waddr_done,wdata_done,addr,w_data,mem[addr>>2],BRESP, BVALID, exp.RDATA, exp.RRESP, exp.RVALID), UVM_NONE)
		  if(exp.RDATA==out_tx.RDATA && exp.RRESP==out_tx.RRESP && exp.RVALID==out_tx.RVALID)
			     begin
				         success++;
				         `uvm_info("SCB",$sformatf("SUCCESS COUNT=%d",success),UVM_NONE);end
		  else
			     begin
				         fail++;
				        `uvm_info("SCB",$sformatf("FAIL COUNT=%d",fail),UVM_NONE);
				        end
		 `uvm_info("SCB","------------------------------------------------------------------", UVM_NONE)

	endtask
endclass
