module parity_check(
    input clk , rst ,
    input par_block_en , sampled_bit , parity_type ,
    input [7:0] p_data ,
    input [5:0] edge_count , prescale ,
    output reg parity_error
);



always@(posedge clk , negedge rst)
begin
    if(!rst)
     parity_error <= 'b0 ;

    else  
    begin 
        if(par_block_en)
        begin 

         if(parity_type)
         begin
          if(sampled_bit == (^p_data) & edge_count == prescale  - 'b1) // sampling a wrong value after sampled bit get updated
           parity_error <= 'b1 ;
          else 
           parity_error <= 'b0 ;
         end 



         else 
         begin
          if(sampled_bit == ~(^p_data) & edge_count == prescale  - 'b1 )
           parity_error <= 'b1 ;
          else 
           parity_error <= 'b0 ;
         end 
        end  //if en



    end // else 
end


endmodule
