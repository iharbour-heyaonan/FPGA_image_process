`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 09:51:43
// Design Name: 
// Module Name: rgb2gray
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
//============== rgb转灰度--三级流水线 ===================
//=======================================================


module rgb2gray(
input               clk         ,
input               rst_n       ,
input   [23:0]      din         ,
input               din_vld     ,

output reg [7:0]    dout        ,
output reg          dout_vld    
    );

reg [7:0]   data_r;
reg [7:0]   data_g;
reg [7:0]   data_b;

reg [17:0]  temp_r;
reg [17:0]  temp_g;
reg [17:0]  temp_b;

reg [1:0]   vld;



//rgb分量寄存 
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        data_r <= 8'b0;
        data_b <= 8'b0;
        data_g <= 8'b0;
    end
    else if(din_vld)
        begin
            data_r <= din[23:16];
            data_g <= din[15:8];
            data_b <= din[7:0];
        end
end

//vld寄存   delay 2clk
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        vld <= 2'b0;
    else begin
        vld <= {vld[0],din_vld}; 
    end
end


//=================================================================
//                rgb2YCrCb算法主体部分
//=================================================================

//rgb_temp分量计算 ==pipe_line1
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        temp_r <= 17'd0;
        temp_g <= 17'd0;
        temp_b <= 17'd0;
    end
    else if(vld[0] == 1'b1) begin   //din_vld有效
        temp_r <= data_r*77;
        temp_g <= data_g*150;
        temp_b <= data_b*29;
    end
end


//dout计算 ==pipe_line2
reg [18:0]  dout_temp;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dout_temp <= 19'd0;
    else if(vld[1] == 1'b1)     //din_vld延时 时钟后
        dout_temp <= (temp_r + temp_g + temp_b)>>8;
end



//dout_vld 此处会延时一个时钟  组合逻辑改为时序逻辑
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dout_vld <= 1'b0;
    else begin
        dout <= dout_temp[7:0];
        dout_vld <= vld[1];
    end       
end
endmodule
