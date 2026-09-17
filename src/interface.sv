include "defines.svh"
interface inf(input ACLK,input ARESETn);    

    logic    [`A_W-1:0] AWADDR;
    logic    [2:0] AWPROT;
    logic  AWVALID;
    logic  AWREADY;

    logic    [`D_W-1:0] WDATA;
    logic    [(`D_W/8)-1:0]  WSTRB;
    logic    WVALID;
    logic    WREADY;

    logic  [1:0] BRESP;
    logic   BVALID;
    logic   BREADY;

    logic  [`A_W-1:0] ARADDR;
    logic  [2:0] ARPROT;
    logic  ARVALID;
    logic  ARREADY;

    logic  [`D_W-1:0] RDATA;
    logic  [1:0] RRESP;
    logic     RVALID;
    logic     RREADY;

clocking inp_mon_cb @(posedge ACLK);
 default input #1 output #1;
input ARESETn,AWADDR,AWPROT,AWVALID,WDATA,WVALID,WSTRB,BREADY,ARADDR,ARPROT,ARVALID,RREADY; 
endclocking

clocking out_mon_cb @(posedge ACLK);
 default  input #1 output #1;
 input AWREADY,WREADY,BRESP,BVALID,ARREADY,RDATA,RVALID,RRESP;
endclocking

clocking drv_cb @(posedge ACLK);
 default  input #1 output #1;
 input AWREADY,WREADY,ARREADY,BVALID,RVALID;
 output AWADDR,AWPROT,AWVALID,WDATA,WVALID,WSTRB,BREADY,ARADDR,ARPROT,ARVALID,RREADY;
endclocking

modport INP_MON(clocking inp_mon_cb);
modport DRV(clocking drv_cb);
modport OUT_MON(clocking out_mon_cb);
endinterface
