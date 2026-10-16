
module FIFO_top #(
  parameter D_SIZE = 8 ,                         // data size
  parameter A_SIZE = 3  ,                         // address size
  parameter P_SIZE = 4  ,                         // pointer width
  parameter F_DEPTH = 8                           // fifo depth
)
 (
   input                    w_clk,              // write domian operating clock
   input                    w_rst,             // write domian active low reset  
   input                    w_inc,              // write control signal 
   input                    r_clk,              // read domian operating clock
   input                    r_rst,             // read domian active low reset 
   input                    r_inc,              // read control signal
   input   [D_SIZE-1:0]     w_data,             // write data bus 
   output  [D_SIZE-1:0]     r_data,             // read data bus
   output                   w_full,               // fifo full flag
   output                   r_empty               // fifo empty flag

);
   

wire [A_SIZE-1:0] r_addr , w_addr ;
wire [P_SIZE-1:0] w2r_ptr , r2w_ptr ;
wire [P_SIZE-1:0] gray_w_ptr , gray_rd_ptr ;

 
fifo_mem #(.F_DEPTH(F_DEPTH), .A_SIZE(3), .D_SIZE(8), .P_SIZE(4) )  u_fifo_mem (
.w_clk(w_clk),              
.w_rstn(w_rst),
.w_inc(w_inc),                             
.w_full(w_full),              
.w_addr(w_addr),            
.r_addr(r_addr),
.w_data(w_data),                        
.r_data(r_data)
); 

DF_Sync #(.DATA_SIZE(4)) u_w2r_sync
(
.sync_clk(r_clk) ,
.sync_rstn(r_rst) ,
.unsync_ip(gray_w_ptr) ,
.sync_op(w2r_ptr)
);


fifo_wr u_fifo_wr (            
.w_clk(w_clk),              
.w_rstn(w_rst),             
.w_inc(w_inc),            
.sync_rd_ptr(r2w_ptr),                
.w_addr(w_addr),            
.gray_w_ptr(gray_w_ptr),        
.full(w_full)
);               


fifo_rd u_fifo_rd (
.r_clk(r_clk), // w_clk              
.r_rstn(r_rst),             
.r_inc(r_inc),              
.sync_wr_ptr(w2r_ptr),                
.rd_addr(r_addr),            
.gray_rd_ptr(gray_rd_ptr),        
.empty(r_empty)
);


DF_Sync #(.DATA_SIZE(4)) u_r2w_sync
(
.sync_clk(w_clk) ,
.sync_rstn(w_rst) ,
.unsync_ip(gray_rd_ptr) ,
.sync_op(r2w_ptr)
);


endmodule
