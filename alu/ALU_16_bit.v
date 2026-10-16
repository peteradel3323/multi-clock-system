module ALU_16_bit #(parameter width = 8 , alu_fun_par = 4 )
(
    input [ width - 1 : 0 ] a , b ,
    input clk , rst , alu_en ,
    input [ alu_fun_par - 1 : 0 ] alu_fun ,
    output reg [ 2 * width - 1 : 0 ] alu_out , 
    output reg out_valid
);


always @ (posedge clk , negedge rst)  
  begin

if(!rst)
begin
     alu_out <= 'b0 ;
     out_valid <= 'b0 ; 
end 

else if(alu_en)
begin 

case(alu_fun)

    4'b0000 : begin
        alu_out <= a + b ;
        out_valid <= 1'b1 ;
    end


    4'b0001 : begin
        alu_out <= a - b ;
         out_valid <= 1'b1 ;
     end

    4'b0010 : begin
        alu_out <= a * b ; 
         out_valid <= 1'b1 ;
    end

    4'b0011 : begin
        alu_out <= a / b ;
         out_valid <= 1'b1 ;
    end

    4'b0100 : begin
        alu_out <= a & b ;
         out_valid <= 1'b1 ;
    end

    4'b0101 : begin
        alu_out <= a | b ;
         out_valid <= 1'b1 ;
    end


    4'b0110 : begin
        alu_out <= ~(a & b) ;
         out_valid <= 1'b1 ;
    end

    4'b0111 : begin
        alu_out <= ~(a | b) ;
         out_valid <= 1'b1 ;
    end

    4'b1000 : begin
        alu_out <= a ^ b ;
         out_valid <= 1'b1 ;
    end

    4'b1001 : begin
        alu_out <= a ~^ b ;
         out_valid <= 1'b1 ;
    end

    4'b1010 : begin

        if(a == b)	begin
            alu_out <= 1 ;
             out_valid <= 1'b1 ;
        end 

        else 	begin
            alu_out <= 0 ;
             out_valid <= 1'b1 ;
        end

    end


    4'b1011 : begin

        if(a > b)	begin
            alu_out <= 2 ;
             out_valid <= 1'b1 ;
        end 

        else 	begin
            alu_out <= 0 ;
             out_valid <= 1'b1 ;
        end

    end

    4'b1100 : begin

        if(a < b)	begin
            alu_out <= 3 ;
             out_valid <= 1'b1 ;
        end 

        else 	begin
            alu_out <= 0 ;
             out_valid <= 1'b1 ;
        end

    end


    4'b1101 : begin
        alu_out <= a >> 1 ;
         out_valid <= 1'b1 ;
    end


    4'b1110 : begin
        alu_out <= a << 1 ;
         out_valid <= 1'b1 ;
    end


	default:	begin
		 alu_out <= 0 ;
         out_valid <= 1'b0 ;

end

endcase

end // else if en is active


else // else (rst & en) is inactive
begin
    out_valid <= 1'b0 ; 
end 

end //always_seq

endmodule
