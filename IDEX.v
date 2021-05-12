module ID_EX (
    //input
      input[31:0] regRD1D
    , input[31:0] regRD2D
    , input[4:0] RsD
    , input[4:0] RtD
    , input[4:0] RdD
    , input[31:0] SignImmeD
    , input[4:0] shamtD
    , input clk
    , input RegWriteD
    , input MemtoRegD
    , input MemWriteD
    , input BranchD
    , input[3:0] ALUControlD
    , input ALUSrcD
    , input RegDstD
    , input CLR
    , input JumpD
    , input JumpRegD
    , input[4:0] WriteRegD
    , input[31:0] returnAddressD
    , input[5:0] opcodeD
    , input[31:0] instrD
    //output
    , output reg[31:0] regRD1E
    , output reg[31:0] regRD2E
    , output reg[4:0] RsE
    , output reg[4:0] RtE
    , output reg[4:0] RdE
    , output reg[31:0] SignImmeE
    , output reg RegWriteE
    , output reg MemtoRegE
    , output reg MemWriteE
    , output reg BranchE
    , output reg[3:0] ALUControlE
    , output reg ALUSrcE
    , output reg RegDstE
    , output reg[4:0] shamtE
    , output reg JumpE
    , output reg JumpRegE
    , output reg[4:0] WriteRegE
    , output reg[31:0] returnAddressE
    , output reg[5:0] opcodeE
    , output reg[31:0] instrE
);
    
always @(posedge clk) begin
  if (CLR == 1'b1) begin
    regRD1E <= 32'b0;
    regRD2E <= 32'b0;
    RsE <= 5'b0;
    RtE <= 5'b0;
    RdE <= 5'b0;
    SignImmeE <= 32'b0;
    RegWriteE <= 1'b0;
    MemtoRegE <= 1'b0;
    MemWriteE <= 1'b0;
    BranchE <= 1'b0;
    ALUControlE <= 4'b0;
    ALUSrcE <= 1'b0;
    RegDstE <= 1'b0;
    shamtE <= 5'b0;
    JumpE <= 1'b0;
    JumpRegE <= 1'b0;
    WriteRegE <= 5'b0;
    returnAddressE <= 32'b0;
    opcodeE <= 5'b0;
    instrE <= 32'b0;
  end
  else begin
    regRD1E <= regRD1D;
    regRD2E <= regRD2D;
    RsE <= RsD;
    RtE <= RtD;
    RdE <= RdD;
    SignImmeE <= SignImmeD;
    RegWriteE <= RegWriteD;
    MemtoRegE <= MemtoRegD;
    MemWriteE <= MemWriteD;
    BranchE <= BranchD;
    ALUControlE <= ALUControlD;
    ALUSrcE <= ALUSrcD;
    RegDstE <= RegDstD;
    shamtE <= shamtD;
    WriteRegE <= WriteRegD;
    returnAddressE <= returnAddressD;
    opcodeE <= opcodeD;
    instrE <= instrD;
  end
end



endmodule