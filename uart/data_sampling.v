module  data_sampling (
  input clk , rst ,
  input sample_block_en ,
  input rx_in ,
  input [5:0] prescale ,
  input [5:0] edge_count ,
  output reg sampled_bit
);

reg bef , mid , after ;

wire [2:0] values;
reg voted_value ;


assign values = {bef , mid , after} ;

always@(posedge clk , negedge rst)
begin 
  if(!rst)
   begin
    sampled_bit  <= 'b1 ;
    bef <= 1 ;
    mid <= 1 ;
    after <= 1;
   end

  else if(sample_block_en)
   begin
     if (edge_count == (prescale >> 1) -1)
      bef <= rx_in ;

     else if (edge_count == (prescale >> 1))
      mid <= rx_in ;

     else if (edge_count == (prescale >> 1) + 1)
      after <= rx_in ;

     sampled_bit <= voted_value ;
   end
 else
  begin
   sampled_bit  <= 'b1 ;
  end

end //always

always@(*)  begin 
case(values)
  'b111: voted_value = 'b1 ;
  'b110: voted_value = 'b1 ;
  'b101: voted_value = 'b1 ;
  'b011: voted_value = 'b1 ;
  default :  voted_value = 'b0 ;
endcase
end //comb_always


endmodule
