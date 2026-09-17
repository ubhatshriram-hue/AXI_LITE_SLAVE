class seq_item extends uvm_sequence_item;
	`uvm_object_utils(seq_item)
	function new(string name="seq_item");
		 super.new(name);
	endfunction
	  bit reset;
	  rand bit    [`A_W-1:0] AWADDR;
	  rand  bit    [2:0] AWPROT;
	  rand  bit  AWVALID;
	  bit  AWREADY;

	  rand   bit    [`D_W-1:0] WDATA;
	  rand  bit    [(`D_W/8)-1:0]  WSTRB;
	  rand  bit    WVALID;
	  bit    WREADY;

	  bit  [1:0] BRESP;
	  bit   BVALID;
	  rand  bit   BREADY;

	  rand   bit  [`A_W-1:0] ARADDR;
	  rand   bit  [2:0] ARPROT;
	  rand   bit  ARVALID;
	  bit  ARREADY;

	  bit  [`D_W-1:0] RDATA;
	  bit  [1:0] RRESP;
	  bit     RVALID;
	  rand  bit     RREADY;
	  rand bit [1:0]trans_type; //1 for write, 0 for read, 2 for read and write
endclass
