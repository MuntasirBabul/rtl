module ALU #
(
    parameter WIDTH = 32
)
(
    input  logic    [WIDTH-1:0] OpA,
    input  logic    [WIDTH-1:0] OpB,
    input  logic    [2:0]       ALUControl,
    output logic    [WIDTH-1:0] ALUResult,
    output logic                Zero
);

always @(*) begin
    case(ALUControl)
    
    3'b000 : begin 
        ALUResult = OpA & OpB;
    end 

    3'b001 : begin 
        ALUResult = OpA | OpB;
    end 

    3'b010 : begin 
        ALUResult = OpA + OpB;
    end 

    3'b011 : begin 
        ALUResult = 'b0;
    end 

    3'b100 : begin 
        ALUResult = OpA - OpB;
    end 

    3'b101 : begin 
        ALUResult = OpA * OpB;
    end 

    3'b110 : begin 
        ALUResult = (OpA < OpB);
    end 

    3'b111 : begin 
        ALUResult = 'b0;
    end 

    default : begin 
        ALUResult = 'b0;
    end
    endcase
end

assign Zero = (ALUResult = 'b0);
endmodule