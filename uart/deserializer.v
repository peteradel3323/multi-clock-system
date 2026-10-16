module deserializer (
  input clk , rst ,
  input deser_block_en , sampled_bit ,
  input [5:0] prescale ,
  input [5:0] edge_count ,
  output reg [7:0] p_data
);

always@(posedge clk , negedge rst)
begin
  if(!rst) 
  begin
    p_data <= 'b0 ;
  end 

  else if(deser_block_en & edge_count == (prescale >> 1) + 2'b10)
  begin
    p_data <= { sampled_bit , p_data [7:1] } ;
  end 

end


endmodule
