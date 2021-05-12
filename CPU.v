module CPU
(
    //input
      input CLK
    , input reset
);

//1st
wire[31:0] PC, PCF;
wire[31:0] instrF;
wire[5:0] opcodeF;
wire[31:0] PCPlus4F;
wire[4:0] WriteRegF;
wire[4:0] RsF, RtF, RdF, shamtF;
wire[15:0] ImmeF;
//2nd
wire[31:0] instrD;
wire[5:0] opcodeD;
wire[31:0] PCPlus4D;
wire[4:0] WriteRegD;
wire[4:0] RsD, RtD, RdD, shamtD;
wire[15:0] ImmeD;
wire[31:0] SignImmeD;
wire[31:0] regRD1D, regRD2D;
wire[31:0] PCBranchD;
wire PCSrcD;
wire[31:0] data1, data2; //after forwarding mulx
wire[31:0] JumpTargetD;
wire[31:0] returnAddress;
wire[31:0] returnAddressD;
//3rd
wire[31:0] instrE;
wire[5:0] opcodeE;
wire[31:0] regRD1E, regRD2E;
wire[4:0] WriteRegE;
wire[4:0] RsE, RtE, RdE, shamtE;
wire[31:0] SignImmeE;
wire[31:0] SrcAE, SrcBE, ALUOutE;
wire[31:0] WriteDataE;
wire[31:0] returnAddressE;
//4th
wire[31:0] instrM;
wire[5:0] opcodeM;
wire[31:0] ALUOutM;
wire[31:0] WriteDataM;
wire[4:0] WriteRegM;
wire[31:0] ReadDataM;
wire[31:0] DMemResult;
wire[31:0] returnAddressM;
//5th
wire[31:0] instrW;
wire[5:0] opcodeW;
wire[31:0] ALUOutW;
wire[4:0] WriteRegW;
wire[31:0] ReadDataW;
wire[31:0] ResultW;
wire[31:0] returnAddressW;
//control unit: use the opcodeD & functD
wire RSDpdF, RTDpdF; //depend on Rs, Rt
wire JumpRegF, JumpRegD;//jr
wire JumpF, JumpD;//j, jr, jal
wire RegWriteF, RegWriteD, RegWriteE, RegWriteM, RegWriteW;
wire MemtoRegF, MemtoRegD, MemtoRegE, MemtoRegM, MemtoRegW;
wire MemWriteF, MemWriteD, MemWriteE, MemWriteM;
wire[3:0] ALUControlF, ALUControlD, ALUControlE;
wire ALUSrcF, ALUSrcD, ALUSrcE;
wire RegDstF, RegDstD, RegDstE;
wire BranchF; //BranchD, BranchE, BranchM;
//hazard unit
wire StallF, FlushE, FlushD;
wire[1:0]  ForwardAE, ForwardBE, ForwardAD, ForwardBD;


//IF stage
assign PC = (PCSrcD===1)? PCBranchD:((JumpD===1)? JumpTargetD:PCPlus4F);

PCReg PCholder
(
      .PC(PC)
    , .enable(StallF)
    , .PCF(PCF)
    , .clk(CLK)
    , .reset(reset)
);

InstructionRAM IMem
(
      .FETCH_ADDRESS(PCF>>2)
    , .ENABLE(1'b1)
    , .DATA(instrF)
);

assign opcodeF = instrF[31:26];
assign RsF = instrF[25:21];
assign RtF = instrF[20:16];
assign RdF = instrF[15:11];
assign WriteRegF = ((JumpF & RegWriteF) === 1)? 5'd31:(RegDstF === 1)? RdF:RtF;
assign ImmeF = instrF[15:0];
assign shamtF = instrF[10:6];

Adder32 fd1
(
      .operandA(PCF)
    , .operandB(32'd4)
    , .result(PCPlus4F)
);

controlUnit controlUnitF
(
      .opcode(instrF[31:26])
    , .funct(instrF[5:0])
    , .RegWriteF(RegWriteF)
    , .MemtoRegF(MemtoRegF)
    , .MemWriteF(MemWriteF)
    , .ALUControlF(ALUControlF)
    , .ALUSrcF(ALUSrcF)
    , .RegDstF(RegDstF)
    , .BranchF(BranchF)
    , .JumpF(JumpF)
    , .JumpRegF(JumpRegF)
    , .RSDpdF(RSDpdF)
    , .RTDpdF(RTDpdF)
);

IF_ID register1
(
     .PCPlus4F(PCPlus4F)
    , .clk(CLK)
    , .CLR(FlushD)
    //control unit
    , .RegWriteF(RegWriteF)
    , .MemtoRegF(MemtoRegF)
    , .MemWriteF(MemWriteF)
    , .ALUControlF(ALUControlF)
    , .ALUSrcF(ALUSrcF)
    , .RegDstF(RegDstF)
    , .BranchF(BranchF)
    , .JumpF(JumpF)
    , .JumpRegF(JumpRegF)
    //data
    , .instrF(instrF)
    , .WriteRegF(WriteRegF)
    , .RsF(RsF)
    , .RtF(RtF)
    , .RdF(RdF)
    , .ImmeF(ImmeF)
    , .shamtF(shamtF)
    , .opcodeF(opcodeF)
    //output
    , .PCPlus4D(PCPlus4D)
    //control
    , .RegWriteD(RegWriteD)
    , .MemtoRegD(MemtoRegD)
    , .MemWriteD(MemWriteD)
    , .ALUControlD(ALUControlD)
    , .ALUSrcD(ALUSrcD)
    , .RegDstD(RegDstD)
    , .BranchD(BranchD)
    , .JumpD(JumpD)
    , .JumpRegD(JumpRegD)
    //data
    , .instrD(instrD)
    , .WriteRegD(WriteRegD)
    , .RsD(RsD)
    , .RtD(RtD)
    , .RdD(RdD)
    , .ImmeD(ImmeD)
    , .shamtD(shamtD)
    , .opcodeD(opcodeD)
);


//ID stage
regFile registers
(
      .A1(RsD)
    , .A2(RtD)
    , .A3(WriteRegW)
    , .WD3(ResultW)
    , .WE3(RegWriteW)
    , .clk(CLK)
    , .RD1(regRD1D)
    , .RD2(regRD2D)
);

signExtender signExtenderD
(
      .immediate(ImmeD)
    , .extendedResult(SignImmeD)
);

Adder32 fd2
(
      .operandA(SignImmeD << 2)
    , .operandB(PCPlus4D)
    , .result(PCBranchD)
);

JumpUnit JumpUnitD
(
    .instr_address(instrD[25:0])
  , .PCPlus4D(PCPlus4D)
  , .JumpRegD(JumpRegD)
  , .JumpTargetD(JumpTargetD)
  , .returnAddressD(returnAddressD)
  , .reg_address(data1)
);

assign data1 = (ForwardAD == 2'b00)? regRD1D : ((ForwardAD == 2'b01)? ResultW:ALUOutM);//branch judgement
assign data2 = (ForwardBD == 2'b00)? regRD2D : ((ForwardBD == 2'b01)? ResultW:ALUOutM);
assign PCSrcD = ((BranchD & (((data1==data2) & (opcodeD==6'b000100)) | ((data1!=data2) & (opcodeD==6'b000101))))===1)? 1'B1:1'B0;

ID_EX register2
( 
      .RegWriteD(RegWriteD)
    , .MemtoRegD(MemtoRegD)
    , .MemWriteD(MemWriteD)
    , .BranchD(BranchD)
    , .ALUControlD(ALUControlD)
    , .ALUSrcD(ALUSrcD)
    , .RegDstD(RegDstD)
    , .regRD1D(regRD1D)
    , .regRD2D(regRD2D)
    , .RsD(RsD)
    , .RtD(RtD)
    , .RdD(RdD)
    , .SignImmeD(SignImmeD)
    , .shamtD(shamtD)
    , .clk(CLK)
    , .CLR(FlushE)
    , .WriteRegD(WriteRegD)
    , .returnAddressD(returnAddressD)
    , .opcodeD(opcodeD)
    , .instrD(instrD)
    //output
    , .regRD1E(regRD1E)
    , .regRD2E(regRD2E)
    , .RsE(RsE)
    , .RtE(RtE)
    , .RdE(RdE)
    , .SignImmeE(SignImmeE)
    , .RegWriteE(RegWriteE)
    , .MemtoRegE(MemtoRegE)
    , .MemWriteE(MemWriteE)
    , .BranchE(BranchE)
    , .ALUControlE(ALUControlE)
    , .ALUSrcE(ALUSrcE)
    , .RegDstE(RegDstE)
    , .shamtE(shamtE)
    , .WriteRegE(WriteRegE)
    , .returnAddressE(returnAddressE)
    , .opcodeE(opcodeE)
    , .instrE(instrE)
);

//EX stage
assign SrcAE = (ForwardAE == 2'b10)? ALUOutM : ((ForwardAE == 2'b01)? ResultW : regRD1E);
assign SrcBE = (ALUSrcE == 1'b0)? ((ForwardBE == 2'b10)? ALUOutM : ((ForwardBE == 2'b01)? ResultW : regRD2E)) : SignImmeE;

ALU alu
(
      .srcA(SrcAE)
    , .srcB(SrcBE)
    , .aluctr(ALUControlE)
    , .shamt(shamtE)
    , .result(ALUOutE)
);

assign WriteDataE = (ForwardBE == 2'b10)? ALUOutM : ((ForwardBE == 2'b01)? ResultW : regRD2E);

EX_MEM register3
(
    .ALUOutE(ALUOutE)
  , .WriteDataE(WriteDataE)
  , .WriteRegE(WriteRegE)
  , .RegWriteE(RegWriteE)
  , .MemtoRegE(MemtoRegE)
  , .MemWriteE(MemWriteE)
  , .clk(CLK)
  , .returnAddressE(returnAddressE)
  , .opcodeE(opcodeE)
  , .ALUOutM(ALUOutM)
  , .WriteDataM(WriteDataM)
  , .WriteRegM(WriteRegM)
  , .RegWriteM(RegWriteM)
  , .MemtoRegM(MemtoRegM)
  , .MemWriteM(MemWriteM)
  , .returnAddressM(returnAddressM)
  , .opcodeM(opcodeM)
  , .instrE(instrE)
  , .instrM(instrM)
);

//MEM stage
MainMemory dataMem
(
    .ENABLE(1'b1)
  , .FETCH_ADDRESS(ALUOutM>>2)
  , .EDIT_SERIAL({{MemWriteM}, {ALUOutM>>2}, {WriteDataM}})
  , .DATA(ReadDataM)
  , .clk(CLK)
);

MEM_WB register4
(
    .clk(CLK)
  , .RegWriteM(RegWriteM)
  , .MemtoRegM(MemtoRegM)
  , .ReadDataM(ReadDataM)
  , .ALUOutM(ALUOutM)
  , .WriteRegM(WriteRegM)
  , .returnAddressM(returnAddressM)
  , .opcodeM(opcodeM)
  , .RegWriteW(RegWriteW)
  , .MemtoRegW(MemtoRegW)
  , .ReadDataW(ReadDataW)
  , .ALUOutW(ALUOutW)
  , .WriteRegW(WriteRegW)
  , .returnAddressW(returnAddressW)
  , .opcodeW(opcodeW)
  , .instrM(instrM)
  , .instrW(instrW)
);

//WB stage
assign ResultW = (opcodeW === 6'b000011)? returnAddressW:((MemtoRegW === 1)? ReadDataW:ALUOutW);

//hazard unit
hazardUnit hazard_unit
(
    .RsF(RsF)
  , .RtF(RtF)
  , .RsD(RsD)
  , .RtD(RtD)
  , .RsE(RsE)
  , .RtE(RtE)
  , .RSDpdF(RSDpdF)
  , .RTDpdF(RTDpdF)
  , .WriteRegD(WriteRegD)
  , .WriteRegE(WriteRegE)
  , .WriteRegM(WriteRegM)
  , .WriteRegW(WriteRegW)
  , .PCSrcD(PCSrcD)
  , .JumpRegF(JumpRegF)
  , .JumpD(JumpD)
  , .BranchF(BranchF)
  , .MemtoRegD(MemtoRegD)
  , .MemtoRegE(MemtoRegE)
  , .RegWriteD(RegWriteD)
  , .RegWriteM(RegWriteM)
  , .RegWriteW(RegWriteW)
  , .ForwardAD(ForwardAD)
  , .ForwardBD(ForwardBD)
  , .ForwardAE(ForwardAE)
  , .ForwardBE(ForwardBE)
  , .StallF(StallF)
  , .FlushD(FlushD)
);







endmodule