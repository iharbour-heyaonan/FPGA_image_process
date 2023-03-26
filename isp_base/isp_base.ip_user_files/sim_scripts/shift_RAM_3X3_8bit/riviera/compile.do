vlib work
vlib riviera

vlib riviera/xbip_utils_v3_0_9
vlib riviera/c_reg_fd_v12_0_5
vlib riviera/c_mux_bit_v12_0_5
vlib riviera/c_shift_ram_v12_0_12
vlib riviera/xil_defaultlib

vmap xbip_utils_v3_0_9 riviera/xbip_utils_v3_0_9
vmap c_reg_fd_v12_0_5 riviera/c_reg_fd_v12_0_5
vmap c_mux_bit_v12_0_5 riviera/c_mux_bit_v12_0_5
vmap c_shift_ram_v12_0_12 riviera/c_shift_ram_v12_0_12
vmap xil_defaultlib riviera/xil_defaultlib

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


