module UART_RX_TOP(
    input clk , rst ,
    input rx_in , parity_en_config , parity_type ,
    input [5:0] prescale ,
    output data_valid , parity_error , stop_error ,
    output [7:0] p_data
);

wire sampled_bit ; // sampled data
wire  start_glitch  ; // error flags 
wire [5:0] edge_count  ;
wire [3:0] bit_count ;
wire par_block_en , count_block_en , start_block_en , stop_block_en , deser_block_en , sample_block_en ; // blocks_en

fsm_rx f0 (
    .clk(clk) ,
    .rst(rst) ,
    .rx_in(rx_in) ,
    .start_glitch(start_glitch) ,
    .stop_error(stop_error) ,
    .parity_error(parity_error) ,
    .parity_en_config(parity_en_config) ,
    .bit_count(bit_count) ,
    .edge_count(edge_count) ,
    .prescale(prescale) ,
    .par_block_en(par_block_en) ,
    .count_block_en(count_block_en) ,
    .start_block_en(start_block_en) ,
    .stop_block_en(stop_block_en) ,
    .deser_block_en(deser_block_en),
    .sample_block_en(sample_block_en) ,
    .data_valid(data_valid) 

);

data_sampling samp (
    .clk(clk) ,
    .rst(rst) ,
    .sample_block_en(sample_block_en) ,
    .rx_in(rx_in),
    .prescale(prescale),
    .edge_count(edge_count),
    .sampled_bit(sampled_bit)
);


edge_bit_counter coun (
	.clk(clk) ,
    .rst(rst) ,
    .count_block_en(count_block_en) ,
    .parity_en_config(parity_en_config) ,
    .prescale(prescale) ,
    .start_glitch(start_glitch) ,
    .bit_count(bit_count) ,
    .edge_count(edge_count)

);



deserializer des_0 (
	.clk(clk) ,
    .rst(rst) ,
    .deser_block_en(deser_block_en) ,
    .sampled_bit(sampled_bit) ,
    .prescale(prescale) ,
    .edge_count(edge_count) ,
    .p_data(p_data)
);





parity_check par_ch (
	.clk(clk) ,
    .rst(rst) ,
    .par_block_en(par_block_en) ,
    .sampled_bit(sampled_bit) ,
    .parity_type(parity_type) ,
    .p_data(p_data) ,
    .prescale(prescale) ,
    .edge_count(edge_count) ,
    .parity_error(parity_error)
);




start_check start_ch (
	.clk(clk) ,
    .rst(rst) ,
    .start_block_en(start_block_en) ,
    .sampled_bit(sampled_bit) ,
    .prescale(prescale) ,
    .edge_count(edge_count) ,
    .start_glitch(start_glitch)
);




stop_check stop_ch (
	.clk(clk) ,
    .rst(rst) ,
    .stop_block_en(stop_block_en) ,
    .sampled_bit(sampled_bit) ,
    .prescale(prescale) ,
    .edge_count(edge_count) ,
    .stop_error(stop_error)
);





endmodule 