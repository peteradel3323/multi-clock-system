module pulse_gen (
    input in_a ,
    input rst ,
    input clk ,
    output pulse
);


reg internal_0 ;

always@(posedge clk , negedge rst)
begin
    if(!rst)
    begin 
     internal_0 <= 'b0 ; 
    end 

    else  
    begin
        internal_0 <= in_a ;
    end 
end 


assign pulse = !internal_0 & in_a ;






endmodule 
