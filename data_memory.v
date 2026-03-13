module data_memory(input [31:0] address,input [31:0] write_data,input memory_write,memory_read,clk,output [31:0]read_data);
reg[31:0] mem[127:0];
assign read_data=(memory_read)?mem[address[9:2]]:32'b0; // address comes from register as 32 bits but we only need 10 bits for indexing, then address is shifted right twice
always@(posedge clk)
begin
if (memory_write) mem[address[6:2]]<=write_data;
end
endmodule
