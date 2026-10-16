onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group CLK.s /sys_tb/ref_clk_tb
add wave -noupdate -expand -group CLK.s /sys_tb/uart_clk_tb
add wave -noupdate -expand -group CLK.s /sys_tb/tx_clk_tb
add wave -noupdate /sys_tb/rst_tb
add wave -noupdate -expand -group UART /sys_tb/DUT/U0_UART/TX_CLK
add wave -noupdate -expand -group UART /sys_tb/DUT/U0_UART/RX_CLK
add wave -noupdate -expand -group UART /sys_tb/DUT/U0_UART/RX_IN_S
add wave -noupdate -expand -group UART -radix hexadecimal /sys_tb/DUT/U0_UART/RX_OUT_P
add wave -noupdate -expand -group UART -color Cyan /sys_tb/DUT/U0_UART/RX_OUT_V
add wave -noupdate -expand -group UART -color Violet /sys_tb/DUT/U0_UART/TX_IN_V
add wave -noupdate -expand -group UART -color Violet -radix unsigned /sys_tb/DUT/U0_UART/TX_IN_P
add wave -noupdate -expand -group UART -color Cyan /sys_tb/DUT/U0_UART/TX_OUT_S
add wave -noupdate -expand -group UART -color Cyan /sys_tb/DUT/U0_UART/TX_OUT_V
add wave -noupdate -expand -group UART -radix unsigned /sys_tb/DUT/U0_UART/Prescale
add wave -noupdate -expand -group UART /sys_tb/DUT/U0_UART/parity_enable
add wave -noupdate -expand -group UART /sys_tb/DUT/U0_UART/parity_type
add wave -noupdate -expand -group UART /sys_tb/DUT/U0_UART/parity_error
add wave -noupdate -expand -group UART /sys_tb/DUT/U0_UART/framing_error
add wave -noupdate -expand -group reg_file /sys_tb/DUT/U0_reg_file/WrData
add wave -noupdate -expand -group reg_file /sys_tb/DUT/U0_reg_file/Address
add wave -noupdate -expand -group reg_file /sys_tb/DUT/U0_reg_file/WrEn
add wave -noupdate -expand -group reg_file /sys_tb/DUT/U0_reg_file/RdEn
add wave -noupdate -expand -group reg_file -radix unsigned /sys_tb/DUT/U0_reg_file/RdData
add wave -noupdate -expand -group reg_file -radix unsigned /sys_tb/DUT/U0_reg_file/reg_0
add wave -noupdate -expand -group reg_file -radix unsigned /sys_tb/DUT/U0_reg_file/reg_1
add wave -noupdate -expand -group reg_file -radix unsigned /sys_tb/DUT/U0_reg_file/reg_2
add wave -noupdate -expand -group reg_file -radix unsigned /sys_tb/DUT/U0_reg_file/reg_3
add wave -noupdate -expand -group reg_file /sys_tb/DUT/U0_reg_file/Rd_valid
add wave -noupdate -expand -group FIFO -color Gold /sys_tb/DUT/U0_fifo/w_clk
add wave -noupdate -expand -group FIFO /sys_tb/DUT/U0_fifo/w_data
add wave -noupdate -expand -group FIFO /sys_tb/DUT/U0_fifo/w_inc
add wave -noupdate -expand -group FIFO /sys_tb/DUT/U0_fifo/r_rst
add wave -noupdate -expand -group FIFO /sys_tb/DUT/U0_fifo/w_rst
add wave -noupdate -expand -group FIFO /sys_tb/DUT/U0_fifo/w_full
add wave -noupdate -expand -group FIFO -color Gold /sys_tb/DUT/U0_fifo/r_clk
add wave -noupdate -expand -group FIFO -color Violet /sys_tb/DUT/U0_fifo/r_inc
add wave -noupdate -expand -group FIFO -color Violet /sys_tb/DUT/U0_fifo/r_empty
add wave -noupdate -expand -group FIFO -color Red -radix unsigned /sys_tb/DUT/U0_fifo/r_data
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/r_inc
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/r_clk
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/empty
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/sync_wr_ptr
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/rd_addr
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/gray_rd_ptr
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/rd_ptr
add wave -noupdate /sys_tb/DUT/U0_fifo/u_fifo_rd/comb_gray_rd_ptr
add wave -noupdate -expand -group ALU -radix unsigned /sys_tb/DUT/U0_alu/a
add wave -noupdate -expand -group ALU -radix unsigned /sys_tb/DUT/U0_alu/b
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/clk
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/rst
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/alu_en
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/alu_fun
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/alu_out
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/carry_flag
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/arith_flag
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/logic_flag
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/cmp_flag
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/shift_flag
add wave -noupdate -expand -group ALU /sys_tb/DUT/U0_alu/out_valid
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/clk
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/rst
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/sync_data_valid
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/sync_data
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/fifo_full
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/alu_out_valid
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/alu_out
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/rd_data_valid
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/reg_rd_data
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/wr_data_2fifo
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/wr_inc
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/alu_en
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/alu_fun
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/gate_en
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/wr_en
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/rd_en
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/reg_add
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/reg_wr_data
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/cu_state
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/nx_state
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/draft
add wave -noupdate -expand -group FSM /sys_tb/DUT/U0_fsm/reg_data_draft
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {990336 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {909897 ns} {1172041 ns}
