module edge_bit_counter (
input clk ,rst ,
input count_block_en , parity_en_config ,
input [5:0] prescale ,
input start_glitch ,
output reg [3:0] bit_count , 
output reg [5:0] edge_count
);




always@(posedge clk , negedge rst)
begin

  if(!rst)

  begin
     bit_count <= 4'b0 ;
     edge_count <= 3'b0 ;
  end

  else if(count_block_en)

  begin
     //edge_count <= edge_count + 'b1 ;

     if(parity_en_config) // first configration (there is a parity bit) you must reach bit index = 10 (11 bit) before reseting 
     begin 
      if(edge_count != prescale - 1'b1)
       edge_count <= edge_count + 'b1 ;

       else if(edge_count == prescale - 1'b1 & bit_count != 10 ) // checking for (not) the last bit but the last edge 
         begin
          if(start_glitch) // checking for a start glitch to reset the counter
           begin
            bit_count <= 4'b0 ;
            edge_count <= 3'b0 ;
           end 
          else  //there is no start glitch & (last edge) but (not last bit) 
           begin 
            bit_count <= bit_count + 1 ;
            edge_count <= 5'b0 ;
           end
        end


       else if(edge_count == prescale - 1'b1) // (it is the last edge) and we are checking if it is the last edge 
         begin
           bit_count <= 4'b0 ;
           edge_count <= 3'b0 ;
        end 
     end


     else // sec configration (no parity bit)  
     begin 
        if(edge_count != prescale - 1'b1)
          edge_count <= edge_count + 'b1 ;
          
        else if(edge_count == prescale - 1'b1 & bit_count != 9 ) 
          begin
          if(start_glitch)
           begin
            bit_count <= 4'b0 ;
            edge_count <= 3'b0 ;
           end 
          else 
           begin 
            bit_count <= bit_count + 1 ;
            edge_count <= 5'b0 ;
           end
          end


        else if(edge_count == prescale - 1'b1)
         begin
          bit_count <= 4'b0 ;
          edge_count <= 3'b0 ;
     end 

     end

  end


end



endmodule
