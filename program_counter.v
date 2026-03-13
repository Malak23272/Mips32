module program_counter(input clock,reset,input [31:0]incremented,output reg [31:0] fetch);
always@(posedge clock )
begin
if(reset||(fetch==32'b111100)) //to avoid accessing uninitialised parts of instruction memory
fetch<=32'b0; //reset to 1st instruction
else
fetch<=incremented; // address moving into the instruction memory is incremented at clock edge
end
endmodule
