module start_check(
    input clk , rst ,
    input start_block_en , sampled_bit ,
    input [5:0] edge_count , prescale ,
    output reg start_glitch 
);


always@(posedge clk , negedge rst)
begin
     if(!rst)
     begin
        start_glitch <= 'b0 ;
     end 

     else
     begin
        if(start_block_en) 
        begin
            if(sampled_bit == 'b1 & edge_count == prescale  - 'b10)
            begin
                 start_glitch <= 'b1 ;
            end 

            else 
            begin
                 start_glitch <= 'b0 ;    
            end

        end

        else 
          start_glitch <= 'b0 ;
     end 
end 



endmodule
