`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/09 11:21:21
// Design Name: 
// Module Name: gray2bin
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
//============== 固定阈值分割--一级流水线 =================
//=======================================================

module gray2bin(
input               clk             ,
input               rst_n           ,
input   [7:0]       gray_din        ,
input               din_vld         ,

output    reg       bin_dout        ,
output    reg       dout_vld        
    );

localparam THRESHOLD = 100;     //阈值


always @(posedge clk or negedge rst_n) begin
    if(!rst_n)  begin
        dout_vld <= 1'b0;
        bin_dout <= 1'b0;
        end
    else begin          //if(din_vld)   此处不需要判断条件 跟着上一步的vld就行
        bin_dout <= (gray_din > THRESHOLD);
        dout_vld <= din_vld;
    end
end

    
endmodule
