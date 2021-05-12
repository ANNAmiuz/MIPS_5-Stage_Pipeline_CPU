module controlUnit 
    (
    //input
      input[5:0] opcode
    , input[5:0] funct
    //output
    , output reg RegWriteF
    , output reg MemtoRegF
    , output reg MemWriteF
    , output reg JumpF//for 3 kinds of jump
    , output reg JumpRegF //0 for jal&j; 1 for jr
    , output reg BranchF
    , output reg[3:0] ALUControlF
    , output reg ALUSrcF
    , output reg RegDstF
    , output reg RSDpdF
    , output reg RTDpdF
    );

always @(*) begin
    RegWriteF = 1'b0;
    MemtoRegF = 1'b0;
    MemWriteF = 1'b0;
    BranchF = 1'b0;
    ALUControlF = 4'b0000;
    ALUSrcF = 1'b0;
    RegDstF = 1'b0;
    JumpF = 1'b0;
    JumpRegF = 1'b0;
    RSDpdF = 1'b0;
    RTDpdF = 1'b0;
    case (opcode)
        6'b000000: begin
            case (funct)
                //add
                6'b100000: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0000;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //addu
                6'b100001: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0000;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //sub
                6'b100010: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0001;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //subu
                6'b100011: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0001;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //and
                6'b100100: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0010;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //nor
                6'b100111: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b1001;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //or
                6'b100101: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0011;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //xor
                6'b100110: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0111;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //sll
                6'b000000: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0100;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b0;
                    RTDpdF = 1'b1;
                end
                //sllv
                6'b000100: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b1010;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //srl
                6'b000010: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0101;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b0;
                    RTDpdF = 1'b1;
                end
                //srlv
                6'b000110: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b1011;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //sra
                6'b000011: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0110;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b0;
                    RTDpdF = 1'b1;
                end
                //srav
                6'b000111: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b1100;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //slt
                6'b101010: begin
                    RegWriteF = 1'b1;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b1000;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b1;
                    JumpF = 1'b0;
                    JumpRegF = 1'b0;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b1;
                end
                //jr
                6'b001000: begin
                    RegWriteF = 1'b0;
                    MemtoRegF = 1'b0;
                    MemWriteF = 1'b0;
                    BranchF = 1'b0;
                    ALUControlF = 4'b0000;
                    ALUSrcF = 1'b0;
                    RegDstF = 1'b0;
                    JumpF = 1'b1;
                    JumpRegF = 1'b1;
                    RSDpdF = 1'b1;
                    RTDpdF = 1'b0;
                end
            endcase
        end
        //lw
        6'b100011: begin
            RegWriteF = 1'b1;
            MemtoRegF = 1'b1;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b1;
            RegDstF = 1'b0;
            JumpF = 1'b0;
            JumpRegF = 1'b0;
            RSDpdF = 1'b1;
            RTDpdF = 1'b0;
        end
        //sw
        6'b101011: begin
            RegWriteF = 1'b0;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b1;
            BranchF = 1'b0;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b1;
            RegDstF = 1'b0;
            JumpF = 1'b0;  
            JumpRegF = 1'b0;
            RSDpdF = 1'b1;
            RTDpdF = 1'b1;          
        end
        //addi
        6'b001000: begin
            RegWriteF = 1'b1;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b1;
            RegDstF = 1'b0; 
            JumpF = 1'b0; 
            JumpRegF = 1'b0; 
            RSDpdF = 1'b1;
            RTDpdF = 1'b0;         
        end
        //addiu
        6'b001001: begin
            RegWriteF = 1'b1;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b1;
            RegDstF = 1'b0;
            JumpF = 1'b0;  
            JumpRegF = 1'b0;    
            RSDpdF = 1'b1;
            RTDpdF = 1'b0;      
        end
        //andi
        6'b001100: begin
            RegWriteF = 1'b1;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b1101;
            ALUSrcF = 1'b1;
            RegDstF = 1'b0;  
            JumpF = 1'b0;   
            JumpRegF = 1'b0;    
            RSDpdF = 1'b1;
            RTDpdF = 1'b0;   
        end
        //ori
        6'b001101: begin
            RegWriteF = 1'b1;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b1110;
            ALUSrcF = 1'b1;
            RegDstF = 1'b0; 
            JumpF = 1'b0;  
            JumpRegF = 1'b0;   
            RSDpdF = 1'b1;
            RTDpdF = 1'b0;      
        end
        //xori
        6'b001110: begin
            RegWriteF = 1'b1;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b1111;
            ALUSrcF = 1'b1;
            RegDstF = 1'b0;  
            JumpF = 1'b0;  
            JumpRegF = 1'b0;   
            RSDpdF = 1'b1;
            RTDpdF = 1'b0;     
        end
        //beq
        6'b000100: begin
            RegWriteF = 1'b0;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b1;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b0;
            RegDstF = 1'b0;    
            JumpF = 1'b0;    
            JumpRegF = 1'b0;    
            RSDpdF = 1'b1;
            RTDpdF = 1'b1;
        end
        //bne
        6'b000101: begin
            RegWriteF = 1'b0;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b1;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b0;
            RegDstF = 1'b0;  
            JumpF = 1'b0;   
            JumpRegF = 1'b0;   
            RSDpdF = 1'b1;
            RTDpdF = 1'b1;    
        end
        //jump
        6'b000010: begin
            RegWriteF = 1'b0;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b0;
            RegDstF = 1'b0;  
            JumpF = 1'b1;
            JumpRegF = 1'b0;
            RSDpdF = 1'b0;
            RTDpdF = 1'b0;
        end
        //jal
        6'b000011: begin
            RegWriteF = 1'b1;
            MemtoRegF = 1'b0;
            MemWriteF = 1'b0;
            BranchF = 1'b0;
            ALUControlF = 4'b0000;
            ALUSrcF = 1'b0;
            RegDstF = 1'b0;  
            JumpF = 1'b1;
            JumpRegF = 1'b0;
            RSDpdF = 1'b0;
            RTDpdF = 1'b0;
        end
    endcase
end
    
endmodule