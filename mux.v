module mux2_1 #(parameter N=32) (input[N-1:0]I0,I1,input S,output reg [N-1:0] F);
always@(*)
case(S)
1'b0: F=I0;
1'b1: F=I1;
default:F=32'b0;
endcase
endmodule


module mux4_1 #(parameter N=32) (input[N-1:0] I0,I1,I2,I3, input [1:0]S, output reg [N-1:0] F);
always @ (*)
begin
case (S)
2'b00: F=I0;
2'b01: F=I1;
2'b10: F=I2;
2'b11: F=I3;
default: F=32'b0;
endcase
end
endmodule
