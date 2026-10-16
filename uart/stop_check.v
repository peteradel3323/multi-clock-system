module stop_check(
    input clk , rst ,
    input stop_block_en , sampled_bit ,
    input [5:0] edge_count , prescale ,
    output reg stop_error 
);


always@(posedge clk , negedge rst)
begin
     if(!rst)
     begin
        stop_error <= 'b0 ;
     end 

     else
     begin
        if(stop_block_en) 
        begin
            if(sampled_bit == 'b0 & edge_count == prescale - 'b10)
            begin
                 stop_error <= 'b1 ;
            end 

            else 
            begin
                 stop_error <= 'b0 ;    
            end

        end 
     end 
end 



endmodule
