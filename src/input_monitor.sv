class input_monitor extends uvm_monitor;
`uvm_component_utils(input_monitor)
function new(string name="input_monitor",uvm_component parent);
 super.new(name,parent);
endfunction

uvm_analysis_port#(seq_item) inp_ap;
virtual inf.INP_MON vif;
axi_config cf;

function void build_phase(uvm_phase phase);
super.build_phase(phase);
uvm_config_db#(axi_config)::get(this,"","config",cf);
vif=cf.intrf;
inp_ap=new("inp_ap",this);
endfunction

seq_item tr;
task run_phase(uvm_phase phase);
forever begin
 @(vif.inp_mon_cb);
 tr=seq_item::type_id::create("tr");
tr.AWADDR= vif.inp_mon_cb.AWADDR;
tr.AWPROT=vif.inp_mon_cb.AWPROT;
tr.AWVALID=vif.inp_mon_cb.AWVALID;
tr.WDATA=vif.inp_mon_cb.WDATA;
tr.WVALID=vif.inp_mon_cb.WVALID;
tr.WSTRB=vif.inp_mon_cb.WSTRB;
tr.BREADY=vif.inp_mon_cb.BREADY;
tr.ARADDR=vif.inp_mon_cb.ARADDR;
tr.ARPROT=vif.inp_mon_cb.ARPROT;
tr.ARVALID=vif.inp_mon_cb.ARVALID;
tr.RREADY=vif.inp_mon_cb.RREADY;
tr.reset=vif.inp_mon_cb.ARESETn;
`uvm_info("INP_MON",$sformatf("AWADDR=%d ,AWPROT=%b ,AWVALID=%b ,WDATA=%d ,WVALID=%b ,WSTRB=%b ,BREADY=%b ,ARADDR=%d ,ARPROT=%b ,ARVALID=%b ,RREADY=%b",
               tr.AWADDR,tr.AWPROT,tr.AWVALID,tr.WDATA,tr.WVALID,tr.WSTRB,tr.BREADY,tr.ARADDR,tr.ARPROT,tr.ARVALID,tr.RREADY),UVM_NONE)


inp_ap.write(tr);
end
endtask
endclass
