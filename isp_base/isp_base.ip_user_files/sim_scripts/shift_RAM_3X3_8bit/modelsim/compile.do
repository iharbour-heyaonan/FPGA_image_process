vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xbip_utils_v3_0_9
vlib modelsim_lib/msim/c_reg_fd_v12_0_5
vlib modelsim_lib/msim/c_mux_bit_v12_0_5
vlib modelsim_lib/msim/c_shift_ram_v12_0_12
vlib modelsim_lib/msim/xil_defaultlib

vmap xbip_utils_v3_0_9 modelsim_lib/msim/xbip_utils_v3_0_9
vmap c_reg_fd_v12_0_5 modelsim_lib/msim/c_reg_fd_v12_0_5
vmap c_mux_bit_v12_0_5 modelsim_lib/msim/c_mux_bit_v12_0_5
vmap c_shift_ram_v12_0_12 modelsim_lib/msim/c_shift_ram_v12_0_12
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vcom -work xbip_utils_v3_0_9 -64 -93 \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_5 -64 -93 \
"../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work c_mux_bit_v12_0_5 -64 -93 \
"../../../ipstatic/hdl/c_mux_bit_v12_0_vh_rfs.vhd" \

vcom -work c_shift_ram_v12_0_12 -64 -93 \
"../../../ipstatic/hdl/c_shift_ram_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../01rgb2gray.srcs/sources_1/ip/shift_RAM_3X3_8bit/sim/shift_RAM_3X3_8bit.vhd" \


