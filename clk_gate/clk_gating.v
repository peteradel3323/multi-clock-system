module clk_gating(
    input clk ,
    input en ,
    output gated_clk 
);

reg enable ;

always@(*)
begin
    if(!clk)
     enable = en ;  
end

assign gated_clk = clk & enable ;



endmodule