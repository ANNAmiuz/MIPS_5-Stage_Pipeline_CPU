module ALU
            ( 
            //input
              input[31:0] srcA
            , input[31:0] srcB
            , input[3:0] aluctr
            , input[4:0] shamt
            //output
            , output reg[31:0] result
            );

    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter AND = 4'b0010;
    parameter OR = 4'b0011;
    parameter SLL = 4'b0100;
    parameter SRL = 4'b0101;
    parameter SRA = 4'b0110;
    parameter XOR = 4'b0111;
    parameter LESS = 4'b1000;
    parameter NOR = 4'b1001;
    parameter SLLV = 4'b1010;
    parameter SRLV = 4'b1011;
    parameter SRAV = 4'b1100;
    parameter ANDI = 4'b1101;
    parameter ORI = 4'b1110;
    parameter XORI = 4'b1111;


    always @(*) begin

        

        //for other operations
        case (aluctr)

        ADD: result <= srcA + srcB;
            //overflow = (srcA[31] == srcB[31] && result[31] != srcA[31])? 1'b1:1'b0;

        SUB: result <= srcA - srcB;
            //overflow = (srcA[31] != srcB[31] && result[31] != srcA[31])? 1'b1:1'b0;

        AND: result <= srcA & srcB;

        OR: result <= srcA | srcB;

        SLL: result <= srcB << shamt;

        SLLV: result <= srcB << srcA[4:0];

        SRL: result <= srcB >> shamt;

        SRLV: result <= srcB >> srcA[4:0];

        SRA: result <= $signed(srcB) >>> shamt;

        SRAV: result <= $signed(srcB) >>> srcA[4:0];

        XOR: result <= srcA ^ srcB;

        LESS: result <= ($signed(srcA) < $signed(srcB))? 32'b1:32'b0;

        NOR: result <= ~(srcA | srcB);

        ORI: result <= srcA | {{16{1'b0}}, srcB[15:0]};

        XORI: result <= srcA ^ {{16{1'b0}}, srcB[15:0]};

        ANDI: result <= srcA & {{16{1'b0}}, srcB[15:0]};

        default: result <= srcA + srcB;

        endcase
    end

endmodule