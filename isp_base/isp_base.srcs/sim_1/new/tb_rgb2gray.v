`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 10:33:32
// Design Name: 
// Module Name: tb_rgb2gray
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//=======================================================
//============== 各图像处理模块单独测试 ===================
//=======================================================

module tb_rgb2gray();

reg     clk;
reg     rst_n;
reg  [7:0]   din;
reg     din_vld;

wire    dout;
wire    dout_vld;


initial clk = 1;
always  #10     clk = ~clk;

initial begin
    rst_n <= 1'b0;
    din_vld <= 1'b0;
    din <=1'b0;
    #200
    rst_n <= 1'b1;
    #200
    din <= 8'h20;
    din_vld <= 1'b1; 
    #100
    din <= 8'h70;
    #100
    din <= 8'hf2;
    #100
    din <= 8'hff;
    #100
    din <= 8'h58;
    #100000
    $stop;
end


gray2bin u0_gray2bin(
.clk             (clk),
.rst_n           (rst_n),
.gray_din        (din),
.din_vld         (din_vld),
.bin_dout        (dout),
.dout_vld        (dout_vld)
);


// rgb2gray u0_rgb2gray(
// .clk        (clk)       ,
// .rst_n      (rst_n)     ,
// .din        (rgb_din)   ,
// .din_vld    (din_vld)   ,
// .dout       (dout_gray) ,
// .dout_vld   (gray_vld)  
// );

endmodule
