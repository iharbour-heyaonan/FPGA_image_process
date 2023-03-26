`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/13 19:45:09
// Design Name: 
// Module Name: median_filter
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


module median_filter(
input               clk         ,
input               rst_n       ,
input   [7:0]       din         ,
input               din_vld     ,

output     [7:0]    dout        ,
output  reg         dout_vld    
    );

wire    [7:0]   row1_data_r;     //从shift_ram接收的第一行缓存 像素点数据
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


// 0级流水 == 三行缓存
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        row1_1 <= 1'b0; row1_2 <= 1'b0; row1_3 <= 1'b0;
        row2_1 <= 1'b0; row2_2 <= 1'b0; row2_3 <= 1'b0;
        row3_1 <= 1'b0; row3_2 <= 1'b0; row3_3 <= 1'b0;
    end
    else if(vld[0]) begin                   //从din开始就进行流水线处理，没有的就补0，直到末尾数--> din == dout
        row1_1 <= row1_data;    row1_2 <= row1_1;   row1_3 <= row1_2; 
        row2_1 <= row2_data;    row2_2 <= row2_1;   row2_3 <= row2_2;    
        row3_1 <= row3_data;    row3_2 <= row3_1;   row3_3 <= row3_2;       
    end
end


//=================================================================
//                中值滤波算法主体部分
//=================================================================

//一级流水 --- 行排列

wire    [7:0]    max1;
wire    [7:0]    mid1;
wire    [7:0]    min1;

sort3 u_row1_sort3(
.clk            (clk),
.rst_n          (rst_n),
.data0          (row1_1),
.data1          (row1_2),
.data2          (row1_3),
.max_data       (max1),		//最大值
.mid_data       (mid1),		//中间值
.min_data       (min1) 		//最小值
);

wire    [7:0]   max2;
wire    [7:0]   mid2;
wire    [7:0]   min2;

sort3 u_row2_sort3(
.clk            (clk),
.rst_n          (rst_n),
.data0          (row2_1),
.data1          (row2_2),
.data2          (row2_3),
.max_data       (max2),		//最大值
.mid_data       (mid2),		//中间值
.min_data       (min2) 		//最小值
);

wire    [7:0]   max3;
wire    [7:0]   mid3;
wire    [7:0]   min3;

sort3 u_row3_sort3(
.clk            (clk),
.rst_n          (rst_n),
.data0          (row3_1),
.data1          (row3_2),
.data2          (row3_3),
.max_data       (max3),		//最大值
.mid_data       (mid3),		//中间值
.min_data       (min3) 		//最小值
);


//二级流水 === 行取值

wire    [7:0]   min_of_max;
wire    [7:0]   mid_of_mid;
wire    [7:0]   max_of_min;

sort3 u_col1_sort3(
.clk            (clk),
.rst_n          (rst_n),
.data0          (max1),
.data1          (max2),
.data2          (max3),
.max_data       (),		//最大值
.mid_data       (),		//中间值
.min_data       (min_of_max) 		//最小值
);

sort3 u_col2_sort3(
.clk            (clk),
.rst_n          (rst_n),
.data0          (mid1),
.data1          (mid2),
.data2          (mid3),
.max_data       (),		//最大值
.mid_data       (mid_of_mid),		//中间值
.min_data       () 		//最小值
);

sort3 u_col3_sort3(
.clk            (clk),
.rst_n          (rst_n),
.data0          (min1),
.data1          (min2),
.data2          (min3),
.max_data       (max_of_min),		//最大值
.mid_data       (),		//中间值
.min_data       () 		//最小值
);


//三级流水 === 得到最终中值
wire    [7:0]   mid_of_final;

sort3 u_final_sort3(
.clk            (clk),
.rst_n          (rst_n),
.data0          (min_of_max),
.data1          (mid_of_mid),
.data2          (max_of_min),
.max_data       (),		//最大值
.mid_data       (mid_of_final),		//中间值
.min_data       () 		//最小值
);

assign dout = mid_of_final;


//根据节拍数给出dout_vld  这边还会延时一拍
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dout_vld <= 1'b0;
    else 
        dout_vld <= vld[3];
end



//行缓存模块

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



