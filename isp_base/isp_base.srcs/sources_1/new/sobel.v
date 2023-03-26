`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/09 16:30:24
// Design Name: 
// Module Name: sobel
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
//================= sobel边缘检测 =====================
//=======================================================

module sobel(
input               clk         ,
input               rst_n       ,
input   [7:0]       din         ,
input               din_vld     ,

output     [7:0]    dout        ,
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


reg     [3:0]   vld;    //有效值  --延时（待研究）
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      vld <= 4'b0;
    else
      vld <= {vld[2:0], din_vld};  //左移
end


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


//=================================================================
//                sobel卷积算法主体部分
//=================================================================

//      Sx                      3*3                           Sy
//  -1  0   1       row1_1    row1_2     row1_3          -1  -2  -1
//  -2  0   2       row1_1    row1_2     row1_3           0   0   0
//  -1  0   1       row1_1    row1_2     row1_3           1   2   1

reg   [9:0]    sum_Sx0;     //max = 255*4 = 1020 --> 10bit
reg   [9:0]    sum_Sx1;
reg   [9:0]    sum_Sy0;
reg   [9:0]    sum_Sy1;

//二级流水 == 计算1/3 行/列 加法
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      sum_Sx0 <= 1'b0;  sum_Sx1 <= 1'b0;
      sum_Sy0 <= 1'b0;  sum_Sy1 <= 1'b0;
    end
    else if(vld[1]) begin
      sum_Sx0 <= row1_1 + 2*row2_1 + row3_1;
      sum_Sx1 <= row1_3 + 2*row2_3 + row3_3;
      sum_Sy0 <= row1_1 + 2*row1_2 + row1_3;
      sum_Sy1 <= row3_1 + 2*row3_2 + row3_3;
    end
end

//三级流水 == 计算单方向梯度 -- 1/3 行/列 差的绝对值计算
reg   [9:0]   abs_x;
reg   [9:0]   abs_y;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      abs_x <= 1'b0;
      abs_y <= 1'b0;
    end
    else if(vld[2]) begin
        abs_x <= (sum_Sx1 >= sum_Sx0) ? (sum_Sx1-sum_Sx0):(sum_Sx0-sum_Sx1);
        abs_y <= (sum_Sy1 >= sum_Sy0) ? (sum_Sy1-sum_Sy0):(sum_Sy0-sum_Sy1);
    end 
end


//四级流水 == 计算总梯度
reg   [10:0]  grad_xy;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      grad_xy <= 1'b0;
    else if(vld[3])
      //grad_xy <= ;
      grad_xy <= (abs_x + abs_y)>=10'd255 ? 10'd255 : 10'd0;      //阈值设定在这
end
assign  dout = grad_xy[7:0];



//dout_vld
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      dout_vld <= 1'b0;
    else
      dout_vld <= vld[3];

end



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
