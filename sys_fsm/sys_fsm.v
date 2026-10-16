module sys_fsm (
    input clk ,
    input rst ,
    input sync_data_valid ,
    input [ 7 : 0 ] sync_data ,
    input fifo_full ,
    input alu_out_valid ,
    input [ 15 : 0 ] alu_out ,
    input rd_data_valid ,
    input [ 7 : 0 ] reg_rd_data ,
    
    output reg [ 7 : 0] wr_data_2fifo ,
    output reg wr_inc ,
    output reg alu_en ,
    output reg [ 3 : 0 ] alu_fun ,
    output reg gate_en ,
    output reg wr_en ,
    output reg rd_en ,
    output reg [ 3 : 0 ] reg_add , 
    output reg [ 7 : 0 ] reg_wr_data
);

reg [ 12 : 0 ] cu_state , nx_state ;
reg [7:0] draft ;
reg [15:0] reg_data_draft ;


localparam  steady =           13'b0_000_000_000_001 , // 1
            wr_addr =          13'b0_000_000_000_010 , // 2
            wr_value =         13'b0_000_000_000_100 , // 4
            rd_addr =          13'b0_000_000_001_000 , // 8
            rd_value =         13'b0_000_000_010_000 , // 16
            fifo_wr =          13'b0_000_000_100_000 , // 32
            alu =              13'b0_000_001_000_000 , // 64
            alu_operate =      13'b0_000_010_000_000 , // 128
            operand_a =        13'b0_000_100_000_000 , // 256
            operand_b =        13'b0_001_000_000_000, // 512 
            alu_2_fifo_wr =    13'b0_010_000_000_000 , // 1024
            alu_2_fifo_wr_2 =  13'b0_100_000_000_000 , // 2048 
            alu_operate_cc =   13'b1_000_000_000_000 ; // 128


  

always@(posedge clk , negedge rst)
begin
    if(!rst)
    begin
        cu_state <= steady ;  
	draft <= 'b0 ;
	reg_data_draft <= 'b0 ;
    end 

    else  
    begin
        cu_state <= nx_state ; 

        if(cu_state == wr_addr | cu_state == rd_addr )
         draft <= sync_data ;

        else if(cu_state == alu_operate_cc)
         draft <= alu_out ;


        if(cu_state == rd_value) 
         reg_data_draft <= reg_rd_data ;

        else if(cu_state == alu_operate)
         reg_data_draft <= alu_out ;



    end 
end



always@(*)
begin
    case(cu_state)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    steady : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b0 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ;
        reg_add = 'b0 ; 
        reg_wr_data = 'b0 ;

        if(sync_data_valid && sync_data == 8'haa )
        begin
            nx_state =  wr_addr ;
        end 

        else if(sync_data_valid && sync_data == 8'hbb )
        begin
            nx_state =  rd_addr ;
        end 

        else if(sync_data_valid && sync_data == 8'hcc )
        begin
            nx_state =  operand_a ;
        end 

        else if (sync_data_valid && sync_data == 8'hdd )
        begin
            nx_state = alu ;
        end
        
        else  
        begin
            nx_state =  steady ;  
        end 
    end 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    wr_addr : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b0 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ;
        reg_add = draft ; 
        reg_wr_data = 'b0 ;

        if(sync_data_valid )
        begin
            nx_state =  wr_value ;
        end 

        else 
        begin
            nx_state =  wr_addr ;
        end 
    end 



    wr_value : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b0 ;
        wr_en = 'b1 ;
        rd_en = 'b0 ;
        reg_add = draft ; 
        reg_wr_data = sync_data ;

        if(sync_data_valid )
        begin
            nx_state =  steady ;
        end 

        else 
        begin
            nx_state =  wr_value ;
        end 
    end 





    rd_addr : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b0 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ;
        reg_add = 'b0 ; 
        reg_wr_data = 'b0 ;

        if(sync_data_valid )
        begin
            nx_state =  rd_value ;
        end 

        else 
        begin
            nx_state =  rd_addr ;
        end 
    end 





    rd_value : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b0 ;
        wr_en = 'b0 ;
        rd_en = 'b1 ;
        reg_add = draft ; 
        reg_wr_data = 'b0 ;

        if(rd_data_valid )
        begin
            nx_state =  fifo_wr ;
        end 

        else 
        begin
            nx_state =  rd_value ;
        end 
    end 



    fifo_wr : begin 
        wr_data_2fifo = reg_data_draft ;
        wr_inc = 'b1 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b0 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ;
        reg_add = 'b0 ; 
        reg_wr_data = 'b0 ;

            nx_state =  steady ;

    end 



    alu : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b1 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b1 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ; 
        reg_add = 'b0 ;   
        reg_wr_data = 'b0 ;

        if(sync_data_valid )
        begin
            nx_state =  alu_operate ;
        end 

        else 
        begin
            nx_state =  alu ;
        end 
    end 


    alu_operate : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b1 ;
        alu_fun = sync_data [3:0] ; 
        gate_en = 'b1 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ; 
        reg_add = 'b0 ;   
        reg_wr_data = 'b0 ;

        if(alu_out_valid & !fifo_full )
        begin
            nx_state = alu_2_fifo_wr ;
        end 

        else 
        begin
            nx_state =  alu_operate ;
        end 
    end 


    operand_a : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ;
        gate_en = 'b0 ;
        wr_en = 'b1 ;
        rd_en = 'b0 ; 
        reg_add = 'b0 ;   
        reg_wr_data = sync_data ;

        if(sync_data_valid )
        begin
            nx_state = operand_b ;
        end 

        else 
        begin
            nx_state =  operand_a ;
        end 
    end



    operand_b : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ;
        gate_en = 'b0 ;
        wr_en = 'b1 ;
        rd_en = 'b0 ; 
        reg_add = 8'b0000_0001 ;   
        reg_wr_data = sync_data ;

        if(sync_data_valid )
        begin
            nx_state = alu_operate_cc ;
        end 

        else 
        begin
            nx_state =  operand_b ;
        end 
    end


    alu_operate_cc : begin 
        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b1 ;
        alu_fun = 'b0 ; 
        gate_en = 'b1 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ; 
        reg_add = 'b0 ;   
        reg_wr_data = 'b0 ;

        if(sync_data_valid)
        begin
            nx_state = alu_operate ;
        end 

        else 
        begin
            nx_state =  alu_operate_cc ;
        end 
    end 




    alu_2_fifo_wr : begin 
        wr_data_2fifo = reg_data_draft[ 7 : 0 ] ;
        wr_inc = 'b1 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b1 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ;
        reg_add = 'b0 ; 
        reg_wr_data = 'b0 ;

            nx_state =  alu_2_fifo_wr_2 ;

    end 


    alu_2_fifo_wr_2 : begin 
        wr_data_2fifo = reg_data_draft[ 15 : 8 ] ;
        wr_inc = 'b1 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ; // watch out it is 4 bits and the frame => 8 bits ????!!!!!!! 
        gate_en = 'b0 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ;
        reg_add = 'b0 ; 
        reg_wr_data = 'b0 ;

            nx_state =  steady ;

    end 

default :	begin 

        wr_data_2fifo = 'b0 ;
        wr_inc = 'b0 ;
        alu_en = 'b0 ;
        alu_fun = 'b0 ;
        gate_en = 'b0 ;
        wr_en = 'b0 ;
        rd_en = 'b0 ;
        reg_add = 'b0 ; 
        reg_wr_data = 'b0 ;

            nx_state =  steady ;
end




    endcase 
end 






endmodule
