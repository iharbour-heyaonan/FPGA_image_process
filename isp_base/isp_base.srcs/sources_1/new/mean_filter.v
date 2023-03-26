`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/09 20:41:23
// Design Name: 
// Module Name: mean_filter
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
//================= 均值滤波 =====================
//=======================================================


module mean_filter(
input               clk         ,
input               rst_n       ,
input   [7:0]       din         ,
input               din_vld     ,

output   [7:0]      dout        ,
output  reg         dout_vld    

    );

wire    [7:0]   row1_data_r;        //从shift_ram接收的第一行缓存 像素点数据
wire    [7:0]   row2_data_r;

wire    [7:0]   row1_data;      //3行缓存
wire    [7:0]   row2_data;
wire    [7:0]   row3_data;

//三行数据存储
assign  row1_data = row1_data_r;
assign  row2_data = row2_data_r;
assign  row3_data = din;

//3*3窗口
reg  [7:0]   row1_1;
reg  [7:0]   row1_2;
reg  [7:0]   row1_3;
reg  [7:0]   row2_1;
reg  [7:0]   row2_2;
reg  [7:0]   row2_3;
reg  [7:0]   row3_1;
reg  [7:0]   row3_2;
reg  [7:0]   row3_3;

reg  [10:0]     pix_sum;      //最高255*8 --> 11位
reg   [7:0]     pix_mean;


reg     [2:0]   vld;    //有效值  --延时（待研究）
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        vld <= 3'b0;
    else
        vld <= {vld[1:0], din_vld};
end

//=================================================================
//                均值滤波算法主体部分
//=================================================================


//一级流水线 == 三行缓存
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        row1_1 <= 1'b0; row1_2 <= 1'b0; row1_3 <= 1'b0;
        row2_1 <= 1'b0; row2_2 <= 1'b0; row2_3 <= 1'b0;
        row3_1 <= 1'b0; row3_2 <= 1'b0; row3_3 <= 1'b0;
    end
    else if(vld[0]) begin
        row1_1 <= row1_data;    row1_2 <= row1_1;   row1_3 <= row1_2; 
        row2_1 <= row2_data;    row2_2 <= row2_1;   row2_3 <= row2_2;    
        row3_1 <= row3_data;    row3_2 <= row3_1;   row3_3 <= row3_2;       
    end
end

//二级流水线 == 求和计算
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        pix_sum <= 11'b0;
    end
    else if(vld[1]) begin
        pix_sum <= row1_1 + row1_2 + row1_3 + row2_1 + row2_3 + row3_1 + row3_2 + row3_3;
    end
end
//三级流水线 == 右移均值计算
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        pix_mean <= 8'b0;
    else if(vld[2]) begin
        pix_mean <= pix_sum>>3;
    end
end
assign dout = pix_mean;



//dout_vld
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dout_vld <= 1'b0;
    else 
        dout_vld <= vld[2];
end


//行缓存两次  128深度--行宽
shift_RAM_3X3_8bit u_shift_RAM_0 (
  .D(din),        // input wire [7 : 0] D
  .CLK(clk),    // input wire CLK
  .SCLR(~rst_n),  // input wire SCLR
  .Q(row2_data_r)        // output wire [7 : 0] Q
);

shift_RAM_3X3_8bit u_shift_RAM_1(
  .D(row2_data_r),        // input wire [7 : 0] D
  .CLK(clk),    // input wire CLK
  .SCLR(~rst_n),  // input wire SCLR
  .Q(row1_data_r)        // output wire [7 : 0] Q
);
endmodule
