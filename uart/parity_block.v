module parity_block (
 input [7:0] in ,
 input clk , rst ,
 input data_valid ,
 input par_type ,
 output reg par_bit
);


always@(posedge clk  , negedge rst)
begin
 if(~rst)
 begin
   par_bit <= 'b 0 ;
 end 
 
 else 
 begin
  if(data_valid)
   begin 
   if(par_type)
    par_bit <= ~^in ;
   else 
    par_bit <= ^in ;
   end
 end
 
end 



endmodule
