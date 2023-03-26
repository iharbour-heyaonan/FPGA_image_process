// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Nov  9 19:57:33 2022
// Host        : Xiaohe-Laptop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/MyData/vivado/01rgb2gray/01rgb2gray.srcs/sources_1/ip/shift_RAM_3X3_8bit/shift_RAM_3X3_8bit_stub.v
// Design      : shift_RAM_3X3_8bit
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_12,Vivado 2018.3" *)
module shift_RAM_3X3_8bit(D, CLK, SCLR, Q)
/* synthesis syn_black_box black_box_pad_pin="D[7:0],CLK,SCLR,Q[7:0]" */;
  input [7:0]D;
  input CLK;
  input SCLR;
  output [7:0]Q;
endmodule
