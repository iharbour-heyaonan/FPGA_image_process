`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 18:38:01
// Design Name: 
// Module Name: top
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
//================= 图像处理顶层模块 =====================
//=======================================================

module top(
input                   clk         ,
input                   rst_n       ,
input      [23:0]       rgb_din     ,
input                   din_vld     ,

output  reg  [23:0]     rgb_out     ,   //处理后rgb数据
output  reg             dout_vld        //输出有效
    );

//output    rbg2gray 
wire    [7:0]   dout_gray   ;
wire            gray_vld    ;
//output    gray2bin 
wire    bin_dout;
wire    bin_vld;
//output    mean_filter
wire    [7:0]   dout_mean;
wire            mean_vld;
//output    sobel
wire    [7:0]   dout_sobel;
wire            sobel_vld;
//output    median_filter
wire    [7:0]   median_out;
wire            median_vld;
//output    erosion
wire    [7:0]   erosion_out;
wire            erosion_vld;
//output    dilation
wire    [7:0]   dilation_out;
wire            dilation_vld;


rgb2gray u0_rgb2gray(
.clk        (clk)       ,
.rst_n      (rst_n)     ,
.din        (rgb_din)   ,
.din_vld    (din_vld)   ,
.dout       (dout_gray) ,
.dout_vld   (gray_vld)  
);


// gray2bin u0_gray2bin(
// .clk             (clk)      ,
// .rst_n           (rst_n)    ,
// .gray_din        (dout_gray)      ,
// .din_vld         (gray_vld)  ,
// .bin_dout        (bin_dout)     ,
// .dout_vld        (bin_vld)
// );

// mean_filter u_mean_filter(
// .clk         (clk),
// .rst_n       (rst_n),
// .din         (dout_gray),
// .din_vld     (gray_vld),
// .dout        (dout_mean),
// .dout_vld    (mean_vld)
//     );


sobel u_sobel(
.clk         (clk),
.rst_n       (rst_n),
.din         (dout_gray),
.din_vld     (gray_vld),

.dout        (dout_sobel),
.dout_vld    (sobel_vld)
    );

// median_filter u_median_filter(
// .clk         (clk),
// .rst_n       (rst_n),
// .din         (dout_gray),
// .din_vld     (gray_vld),
// .dout        (median_out),
// .dout_vld    (median_vld)
//     );

// erosion u_erosion(
// .clk         (clk),
// .rst_n       (rst_n),
// .din         (dilation_out),
// .din_vld     (dilation_vld),
// .dout        (erosion_out),
// .dout_vld    (erosion_vld)
// );


// dilation u_dilation(
// .clk         (clk),
// .rst_n       (rst_n),
// .din         (dout_sobel),
// .din_vld     (sobel_vld),
// .dout        (dilation_out),
// .dout_vld    (dilation_vld)
// );


// 像素点计数
reg     [31:0]    pixel_cnt;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        pixel_cnt <= 0;
    else if(din_vld)
        pixel_cnt <= pixel_cnt+1'b1;
    else
        pixel_cnt <= pixel_cnt;
end


// 处理结果输出时序
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        rgb_out <= 24'b0;
        dout_vld <= 1'b0;
    end
    else  begin                             //if(din_vld)   此处不需要判断条件 跟着上一步的vld就行
        rgb_out <= {3{dout_sobel}};
        dout_vld <= sobel_vld;
    end
     
end


endmodule
