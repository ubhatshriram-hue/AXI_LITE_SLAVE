
class rd_seqr extends uvm_sequencer #(seq_item);
	`uvm_component_utils(rd_seqr)
	function new(string name="rd_seqr",uvm_component parent);
		 super.new(name,parent);
	endfunction
endclass
