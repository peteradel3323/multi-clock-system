module fsm_tx(
   input clk , rst ,
   input data_valid , par_en , ser_done ,
   output reg busy , ser_en ,
   output reg [1:0] sel
);


reg busy_flag ;

localparam  idle = 3'b000 ,
            start = 3'b001 ,
            serial = 3'b010 ,
            parity = 3'b011 ,
            stop = 3'b100 ;


reg [2:0] cu_state , nx_state ;

always@(*)
 begin
   case(cu_state)

    idle :  begin 
      ser_en = 1 ;
      sel ='b01 ;
      busy_flag = 0 ;

      if(data_valid) begin 
         nx_state = start ;
      end 

      else  begin
         nx_state = idle ; 
      end  
    end


    start :  begin 
      ser_en = 0 ;
      sel ='b00 ;
      busy_flag = 1 ;

      nx_state = serial ; 
    end


    serial :  begin 
      ser_en = 0 ;
      sel ='b10 ;
      busy_flag = 1 ;

      if(ser_done & par_en)
      begin
       nx_state = parity ;
      end

      else if (ser_done)
      begin
       nx_state = stop ; 
      end  

      else 
      begin
       nx_state = serial ;
      end 
    end


    parity :  begin 
      ser_en = 0 ;
      sel ='b11 ;
      busy_flag = 1 ;

      nx_state = stop ; 
    end



    stop :  begin 
      ser_en = 0 ;
      sel ='b01 ;
      busy_flag = 1 ;

      nx_state = idle ; 
    end

   default :  begin 
      ser_en = 0 ;
      sel ='b01 ;
      busy_flag = 0 ;

      nx_state = idle ; 
   end

   endcase
 end

always@(posedge clk , negedge rst)
begin
   if(~rst)
   begin
      cu_state <= idle ; 
      busy <= 'b0 ;
   end

   else 
   begin
      cu_state <= nx_state ;
      busy <= busy_flag ;
   end 
end

endmodule 
