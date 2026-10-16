module uart_tx_TOP(
input clk , rst ,
input data_valid , par_type , par_en ,
input [7:0] p_data ,
output busy , tx_out
);



wire [3:0] mux_in ;
wire ser_en , ser_data , ser_done , par_bit ;
wire [1:0] mux_sel;

assign mux_in = {par_bit , ser_data , 1'b1 , 1'b0};

serializer sr (
.clk(clk),
.in(p_data),
.rst(rst),
//.data_valid(data_valid) ,
.ser_en(ser_en), //////////////////////
.out(ser_data) , /////////////////////
.ser_done(ser_done)
);


parity_block pa (
.clk(clk),
.rst(rst),
.in(p_data),
.data_valid(data_valid),
.par_type(par_type),
.par_bit(par_bit)
);

mux4to1 mux (
.clk(clk),
.rst(rst),
.sel(mux_sel),
.mux_out(tx_out),
.in(mux_in)
);



fsm_tx FSM(
.clk(clk),
.rst(rst),
.data_valid(data_valid),
.par_en(par_en),
.ser_done(ser_done),
.busy(busy),
.ser_en(ser_en),
.sel(mux_sel)
);




endmodule
