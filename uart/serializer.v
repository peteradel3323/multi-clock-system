module serializer #(parameter iterations = 8 ) (
input [7:0] in , 
input clk , rst , ser_en ,
output reg out , ser_done
);

reg [7:0] flops ; 
reg [3:0] count ;

always@(*)
begin 
if(count == 0)
 ser_done = 1; 
else 
 ser_done = 0 ; 
end

always@(posedge clk , negedge rst) 
begin

 if (!rst) 	
 begin 
  flops <= 0 ;
  out  <= 0 ;
  count <= 7 ; 
 end //if

 else 	
 begin 

  if(ser_en) 
  begin 
   flops[7] <= 0 ;
   flops[6] <= in[7] ;
   flops[5] <= in[6] ;
   flops[4] <= in[5] ;
   flops[3] <= in[4] ;
   flops[2] <= in[3] ;
   flops[1] <= in[2] ;
   flops[0] <= in[1] ;
   out <= in[0] ;

   count <= 7 ; 

  end //if

  else 
   begin 
     out <= flops[0] ;
     flops[0] <= flops[1] ;
     flops[1] <= flops[2] ;
     flops[2] <= flops[3] ;
     flops[3] <= flops[4] ;
     flops[4] <= flops[5] ;
     flops[5] <= flops[6] ;
     flops[6] <= flops[7] ;
     flops[7] <= 0 ;

     count <= count - 1 ;
        
   end // else 

 end //else of !rst

end // always

endmodule

