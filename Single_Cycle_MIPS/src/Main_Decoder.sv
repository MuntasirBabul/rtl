module Main_Decoder
(
    input  logic [5:0]  Opcode,
    output logic        Jump, 
    output logic        MemtoReg,
    output logic        Branch,
    output logic        ALUSrc,
    output logic        RegDst,
    output logic        RegWrite,
    output logic [1:0]  ALUOp
);

localparam	loadWord        = 6'b100011,
			storeWord       = 6'b101011,
			rType           = 6'b000000,
			addImmediate    = 6'b001000,
			branchIfEqual   = 6'b000100,
			jump_inst       = 6'b000010;

always@(*) begin 
    begin 
    Jump        = 1'b0 ;
	MemtoReg    = 1'b0 ;
	MemWrite    = 1'b0 ;
	Branch      = 1'b0 ;
	ALUSrc      = 1'b0 ;
	RegDst      = 1'b0 ;
	RegWrite    = 1'b0 ;
	ALUOp       = 2'b00 ;
    end
    case(Opcode) 
        loadWord : begin 
            Jump        = 1'b0 ;
            MemtoReg    = 1'b1 ;
            MemWrite    = 1'b0 ;
            Branch      = 1'b0 ;
            ALUSrc      = 1'b1 ;
            RegDst      = 1'b0 ;
            RegWrite    = 1'b1 ;
            ALUOp       = 2'b00 ; end

        storeWord : begin 
            Jump        = 1'b0 ;
            MemtoReg    = 1'b1 ;
            MemWrite    = 1'b1 ;
            Branch      = 1'b0 ;
            ALUSrc      = 1'b1 ;
            RegDst      = 1'b0 ;
            RegWrite    = 1'b0 ;
            ALUOp       = 2'b00 ; end

        rtype: begin 
            Jump        = 1'b0 ;
            MemtoReg    = 1'b0 ;
            MemWrite    = 1'b0 ;
            Branch      = 1'b0 ;
            ALUSrc      = 1'b0 ;
            RegDst      = 1'b1 ;
            RegWrite    = 1'b1 ;
            ALUOp       = 2'b10 ; end

        addImmediate : begin
            Jump        = 1'b0 ;
            MemtoReg    = 1'b0 ;
            MemWrite    = 1'b0 ;
            Branch      = 1'b0 ;
            ALUSrc      = 1'b1 ;
            RegDst      = 1'b0 ;
            RegWrite    = 1'b1 ;
            ALUOp       = 2'b00 ; end
	
	    branchIfEqual :  begin
            Jump        = 1'b0 ;
            MemtoReg    = 1'b0 ;
            MemWrite    = 1'b0 ;
            Branch      = 1'b1 ;
            ALUSrc      = 1'b0 ;
            RegDst      = 1'b0 ;
            RegWrite    = 1'b0 ;
            ALUOp       = 2'b01 ; end
	
	    jump_inst : begin
            Jump        = 1'b1 ;
            MemtoReg    = 1'b0 ;
            MemWrite    = 1'b0 ;
            Branch      = 1'b0 ;
            ALUSrc      = 1'b0 ;
            RegDst      = 1'b0 ;
            RegWrite    = 1'b0 ;
            ALUOp       = 2'b00 ; end
	
        default	: begin
            Jump =      1'b0 ;
            MemtoReg    = 1'b0 ;
            MemWrite    = 1'b0 ;
            Branch      = 1'b0 ;
            ALUSrc      = 1'b0 ;
            RegDst      = 1'b0 ;
            RegWrite    = 1'b0 ;
            ALUOp       = 2'b00 ; end
    endcase
end