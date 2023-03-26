`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/14 11:06:31
// Design Name: 
// Module Name: sort3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 3个数排序，消耗一个时钟
//  用于中值滤波
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sort3(
input			        clk         ,
input			        rst_n       ,
    
input	[7:0]		    data0       ,
input	[7:0]		    data1       ,
input	[7:0]		    data2       ,
    
output	reg [7:0]	    max_data    ,		//最大值
output	reg [7:0]	    mid_data    ,		//中间值
output	reg [7:0]	    min_data     		//最小值
);


	
//==    最大值
always @(posedge clk or negedge rst_n)
begin
	 if(!rst_n)
		max_data <= 7'd0;
	else if(data0 >= data1 && data0 >= data2)
		max_data <= data0; 
	else if(data1 >= data0 && data1 >= data2)
		  max_data <= data1;
	 else if(data2 >= data0 && data2 >= data1)
		  max_data <= data2;
end

//==    中间值

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        mid_data <= 7'd0;
    else if((data1 >= data0 && data0 >= data2) || (data2 >= data0 && data0 >= data1))
        mid_data <= data0;
    else if((data0 >= data1 && data1 >= data2) || (data2 >= data1 && data1 >= data0))
        mid_data <= data1;
    else if((data0 >= data2 && data2 >= data1) || (data1 >= data2 && data2 >= data0))
        mid_data <= data2;
end
 
//==    最小值

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        min_data <= 7'd0;
    else if(data2 >= data0 && data1 >= data0)
        min_data <= data0;
    else if(data2 >= data1 && data0 >= data1)
        min_data <= data1;
    else if(data0 >= data2 && data1 >= data2)
        min_data <= data2;
end

endmodule
