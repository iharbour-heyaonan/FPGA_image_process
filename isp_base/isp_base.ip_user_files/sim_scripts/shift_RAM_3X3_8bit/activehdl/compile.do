vlib work
vlib activehdl

vlib activehdl/xbip_utils_v3_0_9
vlib activehdl/c_reg_fd_v12_0_5
vlib activehdl/c_mux_bit_v12_0_5
vlib activehdl/c_shift_ram_v12_0_12
vlib activehdl/xil_defaultlib

vmap xbip_utils_v3_0_9 activehdl/xbip_utils_v3_0_9
vmap c_reg_fd_v12_0_5 activehdl/c_reg_fd_v12_0_5
vmap c_mux_bit_v12_0_5 activehdl/c_mux_bit_v12_0_5
vmap c_shift_ram_v12_0_12 activehdl/c_shift_ram_v12_0_12
vmap xil_defaultlib activehdl/xil_defaultlib

vcom -work xbip_utils_v3_0_9 -93 \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_5 -93 \
"../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work c_mux_bit_v12_0_5 -93 \
"../../../ipstatic/hdl/c_mux_bit_v12_0_vh_rfs.vhd" \

vcom -work c_shift_ram_v12_0_12 -93 \
"../../../ipstatic/hdl/c_shift_ram_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../01rgb2gray.srcs/sources_1/ip/shift_RAM_3X3_8bit/sim/shift_RAM_3X3_8bit.vhd" \


