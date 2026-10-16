module sys_tb () ;

reg uart_clk_tb , tx_clk_tb , ref_clk_tb , rst_tb  , RX_IN_S_tb ;    
wire  sys_tx_out_tb , sys_tx_out_valid_tb , tx_parity_error_tb , tx_framing_error_tb  ;


reg [7:0] draft_aa ;

parameter ref_clk_per = 10 ;
parameter uart_clk_per = 280 ;
parameter prescale_tb = 32 ;

integer x ;

always #5  ref_clk_tb = !ref_clk_tb ;

always #140 uart_clk_tb = ~uart_clk_tb ;

always #4480 tx_clk_tb = ~tx_clk_tb ;


initial
begin 
    uart_clk_tb ='b1 ;
    tx_clk_tb ='b1 ; 
    ref_clk_tb ='b0 ;
    rst_tb  ='b0 ;
    RX_IN_S_tb ='b0 ;
    
    reset ;
    force_rx_in(8'b1010_1010) ; // aa
    force_rx_in(8'b0000_0000) ; // addr = 0
    force_rx_in(8'b0000_1111) ; // data = 0    

    force_rx_in(8'b1010_1010) ; // aa
    force_rx_in(8'b0000_0001) ; // addr = 1
    force_rx_in(8'b0000_0111) ; // data = 32


    force_rx_in(8'b1011_1011) ; // bb
    force_rx_in(8'b0000_0000) ; // addr = 0


    force_rx_in(8'b1011_1011) ; // bb
    force_rx_in(8'b0000_0001) ; // addr = 1


/////////////////////////////////////////////////////////////////////////////
//////////////////////// test alu no operands //////////////////////////////
    force_rx_in(8'b1101_1101) ; // DD
    force_rx_in(8'b0000_0000) ; // operation  = 0  (add)


/////////////////////////////////////////////////////////////////////////////
//////////////////////// test alu (with) operands //////////////////////////////
    force_rx_in(8'b1100_1100) ; // cc
    force_rx_in(8'b1010_0110) ; // 
    force_rx_in(8'b1000_0101) ; // 
    force_rx_in(8'b0000_0000) ; //  0  (add)


$stop ;

end 




////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// task ////////////////////////////////////////////////
////////////////////////////////// reset ///////////////////////////////////////////////
task reset ();
begin 
rst_tb = 0 ;
@(negedge tx_clk_tb)
rst_tb = 1 ;
end 
endtask



////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// task ///////////////////////////////////////////////
/////////////////////////////// force_rx_in //////////////////////////////////////////
task force_rx_in (input reg [7:0] data );

begin 

RX_IN_S_tb = 'b0 ;                             // start bit 
repeat(prescale_tb) @(negedge uart_clk_tb) ;


for (x = 0; x < 8 ; x = x + 1)                              // data 
begin
  RX_IN_S_tb = data [x]  ;
  repeat(prescale_tb) @(negedge uart_clk_tb) ;
end


 RX_IN_S_tb = 1'b1 ;                             // stop bit 
 repeat(prescale_tb ) @(negedge uart_clk_tb) ;


end 
endtask







sys_top_test DUT (
    .uart_clk(uart_clk_tb) ,
    .ref_clk(ref_clk_tb) , 
    .rst(rst_tb) , 
    .RX_IN_S(RX_IN_S_tb) ,
    .sys_tx_out(sys_tx_out_tb) , 
    .sys_tx_out_valid(sys_tx_out_valid_tb) , 
    .tx_parity_error(tx_parity_error_tb) , 
    .tx_framing_error(tx_framing_error_tb) 
);


endmodule 