module clk_div(
    input ref_clk , rst , clk_en ,
    input [7:0] div_ratio ,
    output reg div_clk 
);


reg [7 : 0] count ;
reg first , gen_clk ;

always@(*)
begin 
    if( |div_ratio[7:1] &  clk_en )
     div_clk  = gen_clk ;
    else  
     div_clk = ref_clk ;
end //comb always

always@(posedge ref_clk , negedge rst)
if (!rst)
 begin
    count <= 0 ;
    first <= 1 ;
    gen_clk <= 1 ;
 end 

else 
 begin
   
    if(div_ratio[0]) // == 1 => odd 
     begin 
         if( (count == (div_ratio >> 1) - 1 ) & first |  (count == div_ratio >> 1) & !first  )
           begin
            gen_clk <= ! gen_clk ;
            first <= ! first ;
            count <= 0 ;
           end  

         else if(clk_en)
           count <= count + 1 ; 
       end 


       else // even 
       begin
          if( count == ( div_ratio >> 1) - 1 )
           begin
            gen_clk <= ! gen_clk ;
            count <= 0 ;
           end  

         else if(clk_en)
           count <= count + 1 ; 
       end
 end 

endmodule 
