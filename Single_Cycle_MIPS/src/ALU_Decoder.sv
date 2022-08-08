module ALU_Decoder
(
    input  logic    [5:0]   Funct,
    input  logic    [1:0]   ALUOp,
    output logic    [2:0]   ALUControl
);

localparam  add = 6'b100000;
            sub = 6'b100010;
            slt = 6'b101010;
            mul = 6'b011100;

always @(*) begin 
    ALUControl = 3'b000;
    case(ALUOp)

    2'b00 :     ALUControl = 3'b010;
    
    2'b01 :     ALUControl = 3'b100;
    
    2'b10 : begin 
        case(Funct)
            add : ALUControl = 3'b010;
            sub : ALUControl = 3'b100;
            slt : ALUControl = 3'b110;
            mul : ALUControl = 3'b101;
            default : ALUControl = 3'b010;
        endcase
    end

    2'b11 :     ALUControl = 3'b010;

    default :   ALUControl = 3'b010;
    endcase
end
endmodule