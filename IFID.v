module IF_ID (
    //input
      input[31:0] PCPlus4F
    , input clk
    , input enable
    , input CLR
    //control unit for F
    , input RegWriteF
    , input MemtoRegF
    , input MemWriteF
    , input[3:0] ALUControlF
    , input ALUSrcF
    , input RegDstF
    , input BranchF
    , input JumpF
    , input JumpRegF
    //data
    , input[31:0] instrF
    , input[5:0] opcodeF
    , input[4:0] WriteRegF
    , input[4:0] RsF
    , input[4:0] RtF
    , input[4:0] RdF
    , input[15:0] ImmeF
    , input[4:0] shamtF
    //output
    , output reg[31:0] PCPlus4D
    //control for D
    , output reg RegWriteD
    , output reg MemtoRegD
    , output reg MemWriteD
    , output reg[3:0] ALUControlD
    , output reg ALUSrcD
    , output reg RegDstD
    , output reg BranchD
    , output reg JumpD
    , output reg JumpRegD
    //data
    , output reg[31:0] instrD
    , output reg[5:0] opcodeD
    , output reg[4:0] WriteRegD
    , output reg[4:0] RsD
    , output reg[4:0] RtD
    , output reg[4:0] RdD
    , output reg[15:0] ImmeD
    , output reg[4:0] shamtD
);


always @(posedge clk) begin
  if (CLR == 1'b1) begin
    instrD <= 32'b0;
    PCPlus4D <= 32'b0;
    RegWriteD <= 1'b0;
    MemtoRegD <= 1'b0;
    MemWriteD <= 1'b0;
    ALUControlD <= 4'b0;
    ALUSrcD <= 1'b0;
    RegDstD <= 1'b0;
    BranchD <= 1'b0;
    JumpD <= 1'b0;
    JumpRegD <= 1'b0;
    WriteRegD <= 5'b0;
    RsD <= 5'b0;
    RtD <= 5'b0;
    RdD <= 5'b0;
    ImmeD <= 16'b0;
    shamtD <= 5'b0;
    opcodeD <= 6'b0;
  end
  else begin
    instrD <= instrF;
    //$display ("Inner InstrF: %b", instrF);
    //$display ("Inner InstrD: %b", instrD);
    PCPlus4D <= PCPlus4F;
    RegWriteD <= RegWriteF;
    MemtoRegD <= MemtoRegF;
    MemWriteD <= MemWriteF;
    ALUControlD <= ALUControlF;
    ALUSrcD <= ALUSrcF;
    RegDstD <= RegDstF;
    BranchD <= BranchF;
    JumpD <= JumpF;
    JumpRegD <= JumpRegF;
    WriteRegD <= WriteRegF;
    RsD <= RsF;
    RtD <= RtF;
    RdD <= RdF;
    ImmeD <= ImmeF;
    shamtD <= shamtF;
    opcodeD <= opcodeF;
  end
end
    
endmodule