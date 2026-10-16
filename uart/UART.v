
module UART # ( parameter DATA_WIDTH = 8)

(
 input   wire                          RST,
 input   wire                          TX_CLK,
 input   wire                          RX_CLK,
 input   wire                          RX_IN_S,
 output  wire   [DATA_WIDTH-1:0]       RX_OUT_P, 
 output  wire                          RX_OUT_V,
 input   wire   [DATA_WIDTH-1:0]       TX_IN_P, 
 input   wire                          TX_IN_V, 
 output  wire                          TX_OUT_S,
 output  wire                          TX_OUT_V,  
 input   wire   [5:0]                  Prescale, 
 input   wire                          parity_enable,
 input   wire                          parity_type,
 output  wire                          parity_error,
 output  wire                          framing_error
);


uart_tx_TOP U0_UART_TX (
.clk(TX_CLK),
.rst(RST),
.p_data(TX_IN_P),
.data_valid(TX_IN_V),
.par_en(parity_enable),
.par_type(parity_type), 
.tx_out(TX_OUT_S),
.busy(TX_OUT_V)
);
 
 
UART_RX_TOP U0_UART_RX (
.clk(RX_CLK),
.rst(RST),
.rx_in(RX_IN_S),
.prescale(Prescale),
.parity_en_config(parity_enable),
.parity_type(parity_type),
.p_data(RX_OUT_P), 
.data_valid(RX_OUT_V),
.parity_error(parity_error),
.stop_error(framing_error)
);
 



endmodule
 
