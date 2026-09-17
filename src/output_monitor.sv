class output_monitor extends uvm_monitor;
 `uvm_component_utils(output_monitor)
 virtual inf.OUT_MON vif;
 axi_config cf; 
 uvm_analysis_port#(seq_item) out_ap;
 seq_item tr;

function new(string name="output_monitor",uvm_component parent);
  super.new(name,parent);
 endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 out_ap=new("out_ap",this);
 if(!uvm_config_db #(axi_config)::get(this,"","config",cf))
    `uvm_fatal(get_type_name(),"Monitor failed")
 vif=cf.intrf;
endfunction

task run_phase(uvm_phase phase);
begin
 tr=seq_item::type_id::create("tr");
 forever begin
	  @(vif.out_mon_cb);
	tr.AWREADY=vif.out_mon_cb.AWREADY;
	tr.WREADY=vif.out_mon_cb.WREADY;
        tr.BRESP=vif.out_mon_cb.BRESP;
        tr.BVALID=vif.out_mon_cb.BVALID;
        tr.ARREADY=vif.out_mon_cb.ARREADY;
        tr.RDATA=vif.out_mon_cb.RDATA;
        tr.RRESP=vif.out_mon_cb.RRESP;
        tr.RVALID=vif.out_mon_cb.RVALID;
        `uvm_info("OUT_MON", $sformatf(
      "DUT Outputs -> AWREADY:%b | WREADY:%0b | BRESP:%0b | BVALID:%0b | ARREADY:%b | RDATA:%0d | RRESP:%0b | RVALID:%0b  ",
      tr.AWREADY, tr.WREADY, tr.BRESP, tr.BVALID, tr.ARREADY, tr.RDATA, tr.RRESP, tr.RVALID), UVM_NONE)
        out_ap.write(tr);
       end

end
endtask

endclass 
