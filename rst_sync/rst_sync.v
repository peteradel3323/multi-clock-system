module rst_sync #(parameter num_stages = 2)(
    input rst , clk ,
    output reg sync_rst
);


reg [num_stages - 2 : 0] stages  ;


always@(posedge clk , negedge rst)  
begin 


 if(!rst)
 begin
  sync_rst <= 1'b0 ;
  stages <= 'b0 ;
 end 

 else 
 begin
    { sync_rst , stages} <= {stages , 1'b1 } ; 
 end 

end

endmodule
