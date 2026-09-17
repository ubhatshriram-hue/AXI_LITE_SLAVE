class active_agent extends uvm_agent;
	`uvm_component_utils(active_agent) 
	function new(string name="active_agent",uvm_component parent);
		   super.new(name,parent);
		 endfunction

		 input_monitor inp_mon;
		 driver drv;
		 wr_seqr ws;
		 rd_seqr rs;

		 function void build_phase(uvm_phase phase);
			  super.build_phase(phase);
			  ws=wr_seqr::type_id::create("ws",this);
			  rs=rd_seqr::type_id::create("rs",this);
			  drv=driver::type_id::create("drv",this);
			  inp_mon=input_monitor::type_id::create("inp_mon",this);
		 endfunction

		 function void connect_phase(uvm_phase phase);
			  super.connect_phase(phase);
			  drv.wr_item_port.connect(ws.seq_item_export);
			  drv.rd_item_port.connect(rs.seq_item_export);
		 endfunction

endclass 
