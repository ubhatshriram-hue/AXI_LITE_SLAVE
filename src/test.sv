

class test extends uvm_test;
	`uvm_component_utils(test)
	function new(string name="test",uvm_component parent);
		super.new(name,parent);
	endfunction
	env e;
	axi_config cf;
	function void build_phase(uvm_phase phase);
		 super.build_phase(phase);
		 e=env::type_id::create("e",this);
		 cf=axi_config::type_id::create("cf",this);
		uvm_config_db#(virtual inf)::get(this,"","vif",cf.intrf);
		uvm_config_db#(axi_config)::set(this,"*","config",cf);
	endfunction


	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction

	sequence1 s1;
	sequence2 s2;
	sequence3 s3;
	sequence4 s4;
	task run_phase(uvm_phase phase);
		  phase.raise_objection(this);
		  s1=sequence1::type_id::create("s1");
		  s2=sequence2::type_id::create("s2");
		  s3=sequence3::type_id::create("s3");
		  s4=sequence4::type_id::create("s4");
		 // fork
		// s1.start(e.aa.seqr);
		        s2.start(e.aa.ws);
		            s3.start(e.aa.ws);
		               // s1.start(e.aa.seqr);
		                   s4.start(e.aa.rs);
		//                    // join
		                       s1.start(e.aa.ws);
		                         #50;
		                           phase.drop_objection(this);
		                           endtask
		                           endclass
