module reg_file #(parameter width = 8 , parameter depth = 16 )  
(
input [width - 1 : 0 ] WrData ,
input  [ 3 : 0 ] Address ,
input WrEn , RdEn ,
input clk ,rst ,
output reg  [width - 1 : 0 ] RdData ,
output [width - 1 : 0 ] reg_0 , reg_1 , reg_2 , reg_3 ,
output reg Rd_valid
);


integer x ;
reg [7 : 0 ] file [15 : 0] ;

always@(posedge clk , negedge rst)
begin
 if (~rst)
  begin
    file [0] <= 'b0 ;  
    file [1] <= 'b0 ;  
    file [2] <= 8'b0010_0000 ;  
    file [3] <= 'b0 ;  

    for(x = 4 ; x < depth ; x = x + 1)
    begin 
      file [x] <= 'b0 ; 
    end 

   RdData   <= 'b0 ;
   Rd_valid <= 1'b0 ;

  end

 else if(WrEn & !RdEn)	begin

    file [Address] <= WrData ; 
    Rd_valid <= 1'b0 ;

  end

 else if(RdEn & !WrEn)	begin
 
    RdData <= file [Address] ;

    Rd_valid <= 1'b1 ;

  end

  else  
   Rd_valid <= 1'b0 ;
  
end // always

assign    reg_0 = file [4'b0000] ;

assign    reg_1  = file [4'b0001] ;

assign    reg_2  = file [4'b0010] ;

assign    reg_3  = file [4'b0011] ;


endmodule
