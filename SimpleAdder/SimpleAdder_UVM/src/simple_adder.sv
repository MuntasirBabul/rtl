module simple_adder #
(
    parameter BUS_WIDTH = 4
)
(
    input logic [BUS_WIDTH-1:0] ina,
    input logic [BUS_WIDTH-1:0] inb,
    input logic clk,
    input logic en_i,
    output logic [BUS_WIDTH-1:0] out,
    output logic en_o
)

integer counter, state;
logic [BUS_WIDTH-1:0] temp_a, temp_b;
logic [BUS_WIDTH:0] temp_out;

initial begin 
    counter = 0;
    temp_a  = 4'b0000;
    temp_b  = 4'b0000;
end

always@(posedge clk) begin 
    if(en_i==1'b1) begin 
        state = 1;
    end
    case(state) begin 
        1 : begin 
            temp_a = temp_a << 1;
            temp_a = temp_a | ina;

            temp_b = temp_b << 1;
            temp_b = temp_b | inb;

            counter = counter + 1;

            if(counter == 2) begin 
                temp_out = temp_a + temp_b;
                state = 2;
            end 
        end 
        2: begin 
            out <= temp_out[4];
            temp_out = temp_out << 1;
            counter = counter + 1;

            if(counter == 3) en_o <= 1'b1;
            if(counter == 4) en_0 <= 1'b0;
            if(counter == 6) begin 
                counter = 0;
                out <= 1'b0;
                state = 0;
            end
        end 
    end
    endcase
    
end 
endmodule