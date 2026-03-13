module ALU #(parameter n=32) (input [3:0] S,input [n-1:0] A,B, output reg [n-1:0] F);
wire cout,w2,w3,EQ,LESS,GR;
wire [1:0] w1; 
wire [n-1:0] a,sum,L;
assign w1={S[2],S[3]};
assign w2=S[2];
assign w3=S[3];
mux2_1 #(32) m1(A,32'b0,w2,a); 
ripple #(32) r1(a,B,w3,sum,cout);
logic #(32) l1(A,B,w1,L);  
comparator32 c1(A,B,EQ,LESS,GR);


always@(*)
begin
if (S[0]==0) F=sum; 
else if ((S[0]==1)&&(S[1]==0)) F=L;
else if ((S[0]==1)&&(S[1]==1)) 
begin
if ((w1==2'b00)&&(GR))F=4'b0001;
else if ((w1==2'b01)&&(LESS))F=4'b0001;
else if ((w1==2'b10)&&(EQ))F=4'b0001;
else F=4'b0;
end
else F=4'b0;
end
endmodule



module ripple #(parameter n=32)( input [n-1:0] A,B,input Cin, output [n-1:0] S, output Cout);

wire [n-1:0]b;
wire[n:0] c;
assign c[0]=Cin;
genvar i;
generate
for(i=0;i<n;i=i+1)
begin:ripple
xor(b[i],Cin,B[i]);
full_adder f1(A[i], b[i], c[i], S[i],c[i+1]);
end
endgenerate
assign Cout=c[n];
endmodule

module full_adder (A,B,Cin,S,Cout);
input A,B,Cin;
output Cout,S;
wire w1,w2,w3;
assign S=( A^B^Cin);
assign Cout=((A&B)|(B&Cin)|(A&Cin));
endmodule


module logic #(parameter n=32)(input [n-1:0] A,B,input[1:0]S ,output [n-1:0] L);
wire [n-1:0] w1,w2,w3,w4;
assign w1=A&B;
assign w2=A^B;
assign w3= A|B;
assign w4= ~B;
mux4_1 #(32) m4(w1,w2,w3,w4,S,L);
endmodule



module comparator32 #(parameter n=32)(input[n-1:0] A,B, output reg EQ,LESS,GR);
wire [n-1:0] diff;
wire cout;
ripple #(32) r2(A,B,1'b1,diff,cout);
always @(*)
begin
if (diff==32'b0) begin EQ=1'b1; GR=1'b0; LESS=1'b0; end
else begin
if(diff[31]==1) begin EQ=1'b0; GR=1'b0; LESS=1'b1; end
else if(diff[31]==0) begin EQ=1'b0; GR=1'b1; LESS=1'b0; end
else begin EQ=1'b0; GR=1'b0; LESS=1'b0; end
end
end
endmodule








