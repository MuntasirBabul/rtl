module Control_Unit  
(
    input  logic [5:0]   Funct,
    input  logic [5:0]   Opcode,
    input  logic         Zero,

    output logic         Jump,
    output logic         MemtoReg,
    output logic         MemWrite,
    output logic         PCSrc,
    output logic         ALUSrc,
    output logic         RegDst,
    output logic         RegWrite,
    output logic [2:0]   ALUControl
);

logic   [1:0]   ALUOp;
logic           Branch;

Main_Decoder U1(
    .Opcode(Opcode),
    .Jump(Jump),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp) 
);

ALU_Decoder U2(
    .Funct(Funct),
    .ALUOp(ALUOp),
    .ALUControl(ALUControl)
);

assign PCSrc = Branch & Zero;
    
endmodule