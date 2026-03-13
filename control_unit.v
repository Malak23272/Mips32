module control_unit(
    input [5:0] opcode,
    output reg regdst, jump, branch, memread, memtoreg, memwrite, reg_write, ALUSRC,
    output reg [1:0] ALUOP
);

always @(opcode) begin
    case(opcode)
        6'b000000: begin // R-Type
            regdst <= 1'b1;
            branch <= 1'b0;
            memread <= 1'b0;
            memwrite <= 1'b0;
            memtoreg <= 1'b0;
            ALUSRC <= 1'b0;
            reg_write <= 1'b1;
            jump <= 1'b0;
            ALUOP <= 2'b10; // Example:  R-Type
        end

        6'b100011: begin // Load Word
            regdst <= 1'b0;
            branch <= 1'b0;
            memread <= 1'b1;
            memwrite <= 1'b0;
            memtoreg <= 1'b1;
            ALUSRC <= 1'b1;
            reg_write <= 1'b1;
            ALUOP <= 2'b00; // Example: ADD for address calculation
            jump <= 1'b0;
        end

        6'b101011: begin // Store Word
            regdst <= 1'bx;
            branch <= 1'b0;
            memread <= 1'b0;
            memwrite <= 1'b1;
            memtoreg <= 1'bx;
            ALUSRC <= 1'b1;
            reg_write <= 1'b0;
            ALUOP <= 2'b00; // Example: ADD for address calculation
            jump <= 1'b0;
        end

        6'b000100: begin // BEQ
            regdst <= 1'bx;
            branch <= 1'b1;
            memread <= 1'b0;
            memwrite <= 1'b0;
            memtoreg <= 1'bx;
            ALUSRC <= 1'b0;
            reg_write <= 1'b0;
            ALUOP <= 2'b01; // Check equality 
        end

        6'b000010: begin // Jump
            regdst <= 1'b0;
            branch <= 1'b0;
            memread <= 1'b0;
            memwrite <= 1'b0;
            memtoreg <= 1'b0;
            ALUSRC <= 1'b0;
            reg_write <= 1'b0;
            ALUOP <= 2'b11; // No ALU operation
            jump <= 1'b1;
        end
        6'b001000: begin //addi
            regdst <= 1'b0;
            branch <= 1'b0;
            memread <= 1'b0;
            memwrite <= 1'b0;
            memtoreg <= 1'b0;
            ALUSRC <= 1'b1;
            reg_write <= 1'b1;
            ALUOP <= 2'b00; // add
            jump <= 1'b0;
        end
        default: begin // Default case
            regdst <= 1'b0;
            branch <= 1'b0;
            memread <= 1'b0;
            memwrite <= 1'b0;
            memtoreg <= 1'b0;
            ALUSRC <= 1'b0;
            reg_write <= 1'b0;
            ALUOP <= 2'b11; // No ALU operation
            jump <= 1'b0;
        end
    endcase
end

endmodule






