class wr_seqr extends uvm_sequencer #(seq_item);
	`uvm_component_utils(wr_seqr)
	function new(string name="wr_seqr",uvm_component parent);
		 super.new(name,parent);
	endfunction
endclass
