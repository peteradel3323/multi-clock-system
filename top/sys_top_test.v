module sys_top_test (
    input uart_clk , ref_clk , rst  , RX_IN_S ,
    
    output  sys_tx_out , sys_tx_out_valid , tx_parity_error , tx_framing_error 
);

wire sync_valid , fifo_full , alu_out_valid , reg_Rd_valid  , alu_en , wr_en , rd_en ;
wire rst_ref , rst_uart , gate_en , bus_enable ;
wire fifo_empty , wr_inc , r_inc_pulse , tx_clk_sig ;
wire [7:0] reg_rd_data , sync_data , reg_wr_data , reg_0 , reg_1 , reg_2 , reg_3 , div_ratio_clk_out , RX_OUT_P , wr_data_2fifo ;
wire [7:0] fifo_r_data  ;
wire [3:0] alu_fun , reg_add ;
wire [15:0] alu_out ;



data_syn U0_data_sync (
    .dist_clk(ref_clk) ,
    .bus_enable(bus_enable) ,
    .enable_pulse(sync_valid) ,
    .sync_bus(sync_data) ,
    .unsync_bus(RX_OUT_P) ,
    .rst(rst_ref)
);



 sys_fsm U0_fsm (
    .clk(ref_clk) ,
    .rst(rst_ref) ,
    .sync_data_valid(sync_valid) ,
    .sync_data(sync_data) ,
    .fifo_full(fifo_full) ,
    .alu_out_valid(alu_out_valid) ,
    .alu_out(alu_out) ,
    .rd_data_valid(reg_Rd_valid) ,
    .reg_rd_data(reg_rd_data) ,
    .wr_data_2fifo(wr_data_2fifo) ,
    .wr_inc(wr_inc) ,
    .alu_en(alu_en) ,
    .alu_fun(alu_fun) ,
    .gate_en(gate_en) ,
    .wr_en(wr_en) ,
    .rd_en(rd_en) ,
    .reg_add(reg_add) , 
    .reg_wr_data(reg_wr_data)
);


reg_file U0_reg_file (
    .Address(reg_add) ,
    .clk(ref_clk) ,
    .RdData(reg_rd_data) ,
    .WrData(reg_wr_data) ,
    .WrEn(wr_en) ,
    .RdEn(rd_en) ,
    .rst(rst_ref) ,
    .reg_0(reg_0) , 
    .reg_1(reg_1) ,
    .reg_2(reg_2) ,
    .reg_3(reg_3) ,
    .Rd_valid(reg_Rd_valid)
);


ALU_16_bit U0_alu (
    .a(reg_0) ,
    .b(reg_1) ,
    .clk(gated_clk) ,
    .rst(rst) ,
    .alu_en(alu_en) ,
    .alu_fun(alu_fun) ,
    .alu_out(alu_out) ,
    .out_valid(alu_out_valid) 
);


rst_sync U0_rst_sync_ref_D (
    .rst(rst) ,
    .clk(ref_clk) ,
    .sync_rst(rst_ref)
);


rst_sync U1_rst_sync_uart_D (
    .rst(rst) ,
    .clk(uart_clk) ,
    .sync_rst(rst_uart)
);





clk_gating U0_clk_gate (
    .clk(ref_clk) ,
    .en(gate_en) ,
    .gated_clk(gated_clk)
);


clk_div U0_clk_div_tx (
    .ref_clk(uart_clk) ,
    .rst(rst_uart) ,
    .clk_en(1'b1) ,
    .div_ratio(8'b00100_000) ,
    .div_clk(tx_clk_sig)
);


clk_div U1_clk_div_rx (
    .ref_clk(uart_clk) ,
    .rst(rst_uart) ,
    .clk_en(1'b1) ,
    .div_ratio(div_ratio_clk_out) ,
    .div_clk(rx_clk)
);



prescale U0_prescale (
    .div_ratio(div_ratio_clk_out) ,
    .reg_prescale(reg_2[5:0])
);


pulse_gen U0_pulse_gen (
    .clk(tx_clk_sig) ,
    .in_a(sys_tx_out_valid) ,  
    .pulse(r_inc_pulse) , 
    .rst(rst_uart)
);


UART U0_UART (
    .RST(rst_uart) ,
    .TX_CLK(tx_clk_sig),
    .RX_CLK(rx_clk),
    .RX_IN_S(RX_IN_S),
    .RX_OUT_P(RX_OUT_P), 
    .RX_OUT_V(bus_enable),
    .TX_IN_P(fifo_r_data), 
    .TX_IN_V(!fifo_empty), 
    .TX_OUT_S(sys_tx_out),
    .TX_OUT_V(sys_tx_out_valid),  
    .Prescale(reg_2[5:0]), 
    .parity_enable(reg_3[7]),
    .parity_type(reg_3[6]),
    .parity_error(tx_parity_error),
    .framing_error(tx_framing_error)
);




FIFO_top U0_fifo (
    .w_data(wr_data_2fifo) ,
    .w_inc(wr_inc) ,
    .r_inc(r_inc_pulse) ,
    .w_clk(ref_clk) ,
    .r_clk(tx_clk_sig) ,
    .r_rst(rst_uart) ,
    .w_rst(rst_ref) ,
    .w_full(fifo_full) ,
    .r_empty(fifo_empty) ,
    //.reg_0(fifo_reg_0) ,
    .r_data(fifo_r_data) 
);





endmodule 
