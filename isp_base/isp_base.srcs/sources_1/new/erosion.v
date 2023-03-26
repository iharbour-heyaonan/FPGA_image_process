`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/13 19:47:18
// Design Name: 
// Module Name: erosion
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


module erosion(
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


reg     [2:0]   vld;    //有效值  --延时（待研究）
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      vld <= 3'b0;
    else
      vld <= {vld[1:0], din_vld};  //左移
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
//                腐蚀算法主体部分
//=================================================================

// 一级流水 === 各行按位与

reg [7:0] p_row1;
reg [7:0] p_row2;
reg [7:0] p_row3;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        p_row1 <= 8'd0;
        p_row2 <= 8'd0;
        p_row3 <= 8'd0;
    end
    else if(vld[1]) begin
        p_row1 <= row1_1 & row1_2 & row1_3;
        p_row2 <= row2_1 & row2_2 & row2_3;
        p_row3 <= row3_1 & row3_2 & row3_3;
    end
end

// 二级流水 === 按位与结果
reg [7:0]   p_mid_out;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        p_mid_out <= 8'd0;
    else if(vld[2])
        p_mid_out <= p_row1 & p_row2 & p_row3;
end

assign dout = p_mid_out;


// vld_out
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dout_vld <= 1'b0;
    else
        dout_vld <= vld[2];
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
