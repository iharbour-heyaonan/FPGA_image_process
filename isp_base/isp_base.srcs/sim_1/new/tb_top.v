`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 18:48:35
// Design Name: 
// Module Name: tb_top
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
//============== top总体输入图像测试 =================
//=======================================================


module tb_top();

reg     clk;
reg     rst_n;

reg  [23:0]   wr_data;
reg     din_vld;

wire    [23:0]  dout;
wire    dout_vld;


//================================ 以下为读写操作内容 =============================

//图像属性：图像宽度 图像高度 图像尺寸 图像像素点起始位
integer bmp_width;
integer bmp_high;
integer bmp_size;
integer start_index;

//bmp file id
integer bmp_file_id;
integer bmp_dout_id;
integer dout_txt_id;

//文件句柄
integer h;
//文件bmp文件数据
reg		[7:0]	rd_data  [0:49300];
reg     [7:0]   rd_data2 [0:49300];

//写操作

integer i = 0;
integer index;
integer j = 0;

parameter CYCLE=20;

always #(CYCLE/2) clk=~clk;
initial
begin
    clk=1'b1;
    rst_n=1'b1;
	din_vld=1'b0;
    #(CYCLE);
    rst_n=1'b0;
    #CYCLE;
    rst_n=1'b1;
    
    //din_vld=1'b0;
	//打开原始图像
	bmp_file_id = $fopen("E:\\MyNewFPGAData\\openfpga\\tbbmps\\myp.bmp","rb");

	//打开输出数据
	dout_txt_id = $fopen("E:\\MyNewFPGAData\\openfpga\\tbtxts\\1119test.txt","w+");

	//读取bmp文件
	h = $fread(rd_data,bmp_file_id);

    // 图像宽度
	bmp_width = {rd_data[21], rd_data[20], rd_data[19], rd_data[18]};
	// 图像高度
	bmp_high = {rd_data[25], rd_data[24], rd_data[23], rd_data[22]};
	// 像素起始位置
	start_index = {rd_data[13], rd_data[12], rd_data[11], rd_data[10]};
	// 图像尺寸
	bmp_size = {rd_data[5], rd_data[4], rd_data[3], rd_data[2]};
	$fclose(bmp_file_id);
    //输出txt
    for(index = start_index; index < bmp_size-2; index = index + 3)begin  //将像素点数据写入txt文件
    	din_vld=1'b1;
        wr_data = {rd_data[index + 2], rd_data[index + 1], rd_data[index]};     //原始rgb数据
        $fwrite(dout_txt_id, "%d,", wr_data[7:0]);
        $fwrite(dout_txt_id, "%d,", wr_data[15:8]);
        $fwrite(dout_txt_id, "%d\n", wr_data[23:16]);
        #(CYCLE);
    end
    din_vld=1'b0;
    $fclose(dout_txt_id);
end

initial
begin
	 #(3*CYCLE);
	//打开输出图像
	bmp_dout_id = $fopen("E:\\MyNewFPGAData\\openfpga\\tbbmps\\sobel1119tb.bmp","wb");//将数据写入bmp
	
	for(i = 0; i < start_index; i = i + 1)begin //写入文件头部信息
        $fwrite(bmp_dout_id, "%c", rd_data[i]);
    end
	
	j=start_index;
	while(j<bmp_size) //写入像素点信息
	begin
		if(dout_vld==1'b1)
		begin
			$fwrite(bmp_dout_id, "%c", dout[7:0]);
			$fwrite(bmp_dout_id, "%c", dout[15:8]);
			$fwrite(bmp_dout_id, "%c", dout[23:16]);
			j=j+3;
		end
		else
		begin
			j=j;
		end
		#CYCLE;
	end
	$fclose(bmp_dout_id);
end


top u0_top(
.clk         (clk),
.rst_n       (rst_n),
.rgb_din     (wr_data),
.din_vld     (din_vld),

.rgb_out     (dout),
.dout_vld    (dout_vld)
    );


endmodule
