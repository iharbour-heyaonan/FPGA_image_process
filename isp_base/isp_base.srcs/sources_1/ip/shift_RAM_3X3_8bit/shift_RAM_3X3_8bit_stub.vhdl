-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Nov  9 19:57:33 2022
-- Host        : Xiaohe-Laptop running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/MyData/vivado/01rgb2gray/01rgb2gray.srcs/sources_1/ip/shift_RAM_3X3_8bit/shift_RAM_3X3_8bit_stub.vhdl
-- Design      : shift_RAM_3X3_8bit
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_RAM_3X3_8bit is
  Port ( 
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    CLK : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end shift_RAM_3X3_8bit;

architecture stub of shift_RAM_3X3_8bit is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "D[7:0],CLK,SCLR,Q[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_shift_ram_v12_0_12,Vivado 2018.3";
begin
end;
