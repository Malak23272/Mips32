module ALU_control (input [1:0] ALUOP ,input[5:0]funct, output reg [3:0] S);
always@(*)
begin
case(ALUOP)
2'b00: S=4'b0000; //add for lw,sw
2'b01: S=4'b0111; // check equality for beq
2'b10: S= funct[3:0]; // ALU functions for R-type
default: S=4'b1111;
endcase
end
endmodule
//funct=instruction[5:0]
