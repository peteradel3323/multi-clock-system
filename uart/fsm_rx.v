
// FSM draft
module fsm_rx (
    input clk , rst ,
    input rx_in , start_glitch , stop_error , parity_error , parity_en_config ,
    input [3:0] bit_count ,
    input [5:0] edge_count ,
    input [5:0] prescale ,
    output reg par_block_en , count_block_en , start_block_en , stop_block_en ,
    output reg deser_block_en , sample_block_en , data_valid 
);

localparam  steady =     5'b00001 ,
            start =      5'b00010 ,
            recieve =    5'b00100 ,
            parity =     5'b01000 ,
            stop_valid = 5'b10000 ;
           

reg [4:0] cu_state , nx_state ;
reg data_valid_sig ;

always@(posedge clk , negedge rst)
begin
    if(!rst)
    begin
        cu_state <= steady ;
	data_valid <= 'b0 ;
    end  

    else 
    begin
        cu_state <= nx_state ;
	data_valid <= data_valid_sig ;
    end 
end 


always@(*)
begin
    case(cu_state)
    
    steady :
    begin
        par_block_en = 1'b0 ;
        start_block_en = 1'b0 ;
        stop_block_en = 1'b0 ;
        deser_block_en = 1'b0 ;
        sample_block_en = 1'b1 ;
        data_valid_sig = 1'b0 ;

        if(rx_in == 0)
        begin
         nx_state = start ;
         count_block_en = 1 ;
        end 

        else 
        begin 
         nx_state = steady ;
         count_block_en = 1'b0 ;
        end
    end 

////////////////////////////////////////////////////////////////
   
    start :
    begin
        par_block_en = 0 ;
        start_block_en = 1 ;
        stop_block_en = 0 ;
        deser_block_en = 0 ;
        count_block_en = 1 ;
        sample_block_en = 1 ;
        data_valid_sig = 0 ;

        if( !start_glitch & edge_count == prescale - 1'b1)
         nx_state = recieve ;

        else if(edge_count < prescale - 1'b1)
         nx_state = start ;

        else  
         nx_state = steady ;
         
    end 

////////////////////////////////////////////////////////////////

    recieve :
    begin
        par_block_en = 1'b0 ;
        start_block_en = 1'b0 ;
        stop_block_en = 1'b0 ;
        deser_block_en = 1'b1 ;
        count_block_en = 1'b1 ;
        sample_block_en = 1'b1 ;
        data_valid_sig = 1'b0 ;

        if(bit_count == 4'b1000 & edge_count == prescale - 1'b1  & parity_en_config)
         nx_state = parity ;

        else if(bit_count == 4'b1000 & edge_count == prescale - 1'b1)
         nx_state = stop_valid ;

        else  
         nx_state = recieve ;
         
    end 



    parity :
    begin
        par_block_en = 1'b1 ;
        start_block_en = 1'b0 ;
        stop_block_en = 1'b0 ;
        deser_block_en = 1'b0 ;
        count_block_en = 1'b1 ;
        sample_block_en = 1'b1 ;
        data_valid_sig = 1'b0 ;


        if(edge_count == prescale - 1'b1 )
         nx_state = stop_valid ; 

        else  
         nx_state = parity ;

    end 


    stop_valid :
    begin
        par_block_en = 1'b0 ;
        start_block_en = 1'b0 ;
        stop_block_en = 1'b1 ;
        deser_block_en = 1'b0 ;
        count_block_en = 1'b1 ;
        sample_block_en = 1'b1 ;


        if(edge_count == prescale - 1'b1  & ! ( parity_en_config & parity_error) & !stop_error )
        begin 
         data_valid_sig = 1'b1 ;   
         nx_state = steady ; 
        end 

        else  if(edge_count == prescale - 1'b1)
        begin 
         nx_state = steady ;
         data_valid_sig = 1'b0 ;
        end 

        else 
        begin
         nx_state = stop_valid ;  
	 data_valid_sig = 1'b0 ;  
        end 
    end 





    default :
    begin
        par_block_en = 1'b0 ;
        start_block_en = 1'b0 ;
        stop_block_en = 1'b0 ;
        deser_block_en = 1'b0 ;
        count_block_en = 1'b0 ;
        sample_block_en = 1'b1 ;
        data_valid_sig = 1'b0 ;

         nx_state = steady ;
    end 

    endcase 
end 


endmodule
