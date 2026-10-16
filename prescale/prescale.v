module prescale (
    input [ 5 : 0 ] reg_prescale ,
    output reg [ 7 : 0 ] div_ratio
);


always@(*)
begin 
case(reg_prescale)

    6'b100_000 :
      div_ratio = 8'b00_000_001 ;

    6'b010_000 :
      div_ratio = 8'b00_000_010 ;

    6'b001_000 :
      div_ratio = 8'b00_000_100 ;

    6'b000_100 :
      div_ratio = 8'b00_001_000 ;

default :
	div_ratio = 8'b00_000_000 ;

endcase

end

endmodule 
