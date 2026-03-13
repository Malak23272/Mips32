module register_file(input clk,reg_write,input[4:0] rs,rt,write_reg, input [31:0]write_data,instruction,output[31:0] read_data1,read_data2);
reg [31:0] register [31:0];
assign read_data1=register[rs];
assign read_data2=register[rt]; 
initial begin
	register[5'b0]=32'b0;
end
always@(posedge clk)
begin
if(reg_write) register[write_reg]<=write_data;
end
endmodule
//reg_write ---> enable. write register ---> register to write on
