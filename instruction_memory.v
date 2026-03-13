module inst_mem (input[31:0] address, output [31:0]instruction);
reg [31:0] inst_memory [15:0]; //reduced memory according to number of instructions
//alu instructions
//op_rs_rt_rd_00000_fnct
//op_8_9_10_ _
initial
begin
//i type
inst_memory[0]=32'b001000_00000_01000_0000000000000011; //addi  t0=0+3
inst_memory[1]=32'b001000_00000_01001_0000000000001010; //addi  t1=0+10

//r-type
inst_memory[2]=32'b000000_01000_01001_01010_00000_000000;//add t0 and t1 and store in t3 
inst_memory[3]=32'b000000_01000_01001_01010_00000_001000;//sub
inst_memory[4]=32'b000000_01000_01001_01010_00000_001100;//2's comp
inst_memory[5]=32'b000000_01000_01001_01010_00000_000001;//and
inst_memory[6]=32'b000000_01000_01001_01010_00000_001001;//xor
inst_memory[7]=32'b000000_01000_01001_01010_00000_000101;//or
inst_memory[8]=32'b000000_01000_01001_01010_00000_001101;//not
inst_memory[9]=32'b000000_01000_01001_01010_00000_000011;// a greater
inst_memory[10]=32'b000000_01000_01001_01010_00000_001011;//a less
inst_memory[11]=32'b000000_01000_01001_01010_00000_000111;// equal
//memory store-load
//op_rs_rt_imm

inst_memory[12]=32'b101011_01001_01010_0000000000000000;//sw. value stored in t3 is stored in memory inside the address that is in t1(10)
inst_memory[13]=32'b100011_01001_01100_0000000000000000;//lw. read from address stored in t1 and store the value of word in reg12. reg12=mem[address stored in t1]


//jump j-TYPE
inst_memory[14]=32'b000010_0000000000000000000000000100;  // Jump to address 4
//beq consideration
inst_memory[15]=32'b000100_10000_10001_0000_0000_0000_0100;// beq $s0=$s1 offset =4
end
assign instruction=inst_memory[address[16:2]];//to divide address by 4 (word align by right shift)
// address is 32 bits but only 6 bits are needed due to memory size
endmodule
