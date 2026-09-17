class sequence1 extends uvm_sequence #(seq_item);
	`uvm_object_utils(sequence1)
	function new(string name="sequence1");
		super.new(name);
	endfunction
	task body();
		 req=seq_item::type_id::create("req");
		 start_item(req);
		  assert(req.randomize() with { AWVALID==1; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
		 finish_item(req);
		   
	endtask
endclass

class sequence2 extends uvm_sequence #(seq_item);
	`uvm_object_utils(sequence2)
	function new(string name="sequence2");
		super.new(name);
	endfunction
	task body();
		repeat(10)  begin
			 req=seq_item::type_id::create("req");
			 start_item(req);
			  assert(req.randomize() with { AWVALID==1; WVALID==0;trans_type==1;BREADY==1; ARVALID==0; } )
			 finish_item(req);

			 start_item(req);
			  assert(req.randomize() with { AWVALID==0; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
			 finish_item(req);
		end 
	endtask
endclass

class sequence3 extends uvm_sequence #(seq_item);
	`uvm_object_utils(sequence3)
	function new(string name="sequence3");
		super.new(name);
	endfunction
	task body();
		repeat(10) begin
			 req=seq_item::type_id::create("req");
			 start_item(req);
			  assert(req.randomize() with { AWVALID==0; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
			 finish_item(req);
			 start_item(req);
			  assert(req.randomize() with { AWVALID==1; WVALID==0;trans_type==1;BREADY==1; ARVALID==0; } )
			 finish_item(req);
		end
	endtask
endclass


class sequence4 extends uvm_sequence #(seq_item);
	`uvm_object_utils(sequence4)
	function new(string name="sequence4");
		super.new(name);
	endfunction
	task body();
		 req=seq_item::type_id::create("req");
		 repeat(10) begin
			  start_item(req);
			   assert(req.randomize() with { AWVALID==0; WVALID==0;trans_type==0;BREADY==0; ARVALID==1;RREADY==1; } )
			  finish_item(req);end
	endtask

endclass
