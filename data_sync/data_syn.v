module data_syn #(parameter width = 8  , stages = 2) (
    input dist_clk , rst ,
    input [width - 1 : 0] unsync_bus ,
    input bus_enable ,
    output reg [width - 1 : 0] sync_bus ,
    output reg enable_pulse
);

reg [stages - 1 : 0] syn_flops ;
reg pulse_gen_flop ;
wire pulse ;

assign pulse = !pulse_gen_flop & syn_flops[0] ;


always@(posedge dist_clk , negedge rst )
begin 

if(!rst)
begin
     sync_bus <= 0 ;
     enable_pulse <= 0 ;
     syn_flops <= 0 ;
     pulse_gen_flop <= 0 ;
end 

else 
begin
    {syn_flops , pulse_gen_flop } <= {bus_enable , syn_flops } ;

    enable_pulse <= pulse ;

    if(pulse)
      sync_bus <= unsync_bus ;
    else 
      sync_bus <= sync_bus ;


end 


end 

endmodule 
