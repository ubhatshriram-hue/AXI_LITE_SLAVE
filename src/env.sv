class env extends uvm_env;
	`uvm_component_utils(env)
	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	active_agent aa;
	passive_agent pa;
	scoreboard scb;
	subscriber sub;

	function void build_phase(uvm_phase phase);
		 super.build_phase(phase);
		 aa=active_agent::type_id::create("aa",this);
		 pa=passive_agent::type_id::create("pa",this);
		 scb=scoreboard::type_id::create("scb",this);
		 sub=subscriber::type_id::create("sub",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		  	 super.connect_phase(phase);
			aa.inp_mon.inp_ap.connect(scb.inp_fifo.analysis_export);
			pa.out_mon.out_ap.connect(scb.out_fifo.analysis_export);
			aa.inp_mon.inp_ap.connect(sub.ap);
	endfunction
endclass
