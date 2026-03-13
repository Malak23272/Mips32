module MIPS (input clk, reset ,output [31:0] F);
wire [31:0]next_inst,incremented,inst_addr,inst,write_data_reg,write_data_mem,read_data1,read_data2,ALU_res,ALU_in2,read_data_mem,sign_shift,sign_ext,brn,jump_addr,inc_brn;
wire reg_dst, jump, branch, memory_read, memtoreg, memory_write, reg_write, ALUSRC,cout,cout2,brn_check;
wire [1:0] ALUOP;
wire [4:0] rs,rt,rd,write_reg;
wire [3:0] S;
assign rs=inst[25:21];
assign rt=inst[20:16];
assign rd=inst[15:11];

//Fetching instruction
program_counter PC(clk, reset, next_inst, inst_addr);
inst_mem IM(inst_addr,inst);
//decoding instruction
control_unit CU( inst[31:26],reg_dst, jump, branch, memory_read, memtoreg, memory_write, reg_write, ALUSRC, ALUOP);
mux2_1 #(5) m3(rt,rd,reg_dst,write_reg); // choosing which register to write on
register_file RF(clk,reg_write,rs,rt,write_reg,write_data_reg,inst,read_data1,read_data2);
sign_extension SE(inst[15:0], sign_ext);
mux2_1 #(32) m4(read_data2,sign_ext,ALUSRC,ALU_in2);
// Excecution
ALU_control AC (ALUOP ,inst[5:0], S);
ALU#(32) A1(S,read_data1,ALU_in2, ALU_res);
// storing-reading memory
assign write_data_mem=read_data2;
data_memory DM(ALU_res,write_data_mem,memory_write,memory_read,clk,read_data_mem);
mux2_1 #(32) m5(ALU_res,read_data_mem,memtoreg,write_data_reg);
//prepare next instruction
ripple #(32) r2(inst_addr,32'b100,1'b0,incremented,cout);
and(brn_check,branch,ALU_res);
assign sign_shift= sign_ext<<<2; //for branch
ripple #(32) r3(incremented,sign_shift,1'b0,brn,cout2);
mux2_1 #(32) m6(incremented,brn,brn_check,inc_brn);
assign jump_addr={incremented[31:28],inst[25:0]<<2}; // inst shift left twice then concatenated with the highest 4 bits of the incremented address (for jump)
mux2_1 #(32) m7(inc_brn,jump_addr,jump,next_inst);
assign F=ALU_res;
endmodule
