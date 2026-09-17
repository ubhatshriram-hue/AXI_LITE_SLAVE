


class axi_config extends uvm_object;

    `uvm_object_utils(axi_config)
    virtual inf intrf;

    uvm_active_passive_enum input_agent_is_active;
    uvm_active_passive_enum output_Agent_is_active;

    function new(string name="axi_config");
        super.new(name);
    endfunction
    
endclass
