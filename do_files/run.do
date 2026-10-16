vlib work
vlog ../*/*.*v
vsim -gui -voptargs="+acc" work.sys_tb
do wave.do
run -all