

class subscriber extends uvm_subscriber #(seq_item);
	`uvm_component_utils(subscriber)
	uvm_analysis_imp #(seq_item,subscriber) ap;
	seq_item tr;
	covergroup cg;
		 coverpoint tr.AWPROT; 
		 coverpoint tr.AWVALID; 
		 coverpoint tr.WSTRB; 
		 coverpoint tr.WVALID; 
		 coverpoint tr.BREADY; 
		 coverpoint tr.ARPROT; 
		 coverpoint tr.RREADY;
	endgroup 
	function new(string name="subscriber",uvm_component parent);
		super.new(name,parent);
		ap=new("ap",this);
		cg=new();
	endfunction

	function void write(seq_item t);
		 tr=t;
		 cg.sample();
	endfunction
endclass
