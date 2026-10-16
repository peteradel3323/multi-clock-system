module mux4to1 (
input [1:0] sel ,
input clk , rst ,
input [3:0] in ,
output reg mux_out
);

reg out ;


always@(posedge clk , negedge rst)
begin 
 if(~rst)
 begin
  mux_out <= 'b1 ; 
 end

 else 
 begin
  mux_out <= out ; 
 end

end



always@(*)	begin 

 case (sel) 
   'b00 : 	begin
	out = 'b0 ;
	end
   'b01 :	begin
	out = 'b1 ;
	end
   'b10 :	begin 
	out = in[2] ;
	end
   'b11 :	begin
	out = in[3] ;
	end
 endcase

end //always

endmodule
