module hazardUnit(
    //input
      input[4:0] RsF
    , input[4:0] RtF
    , input[4:0] RsD
    , input[4:0] RtD
    , input[4:0] RsE
    , input[4:0] RtE
    , input RSDpdF
    , input RTDpdF
    , input[4:0] WriteRegD //stall for load --> ALU/branch/jr
    , input[4:0] WriteRegE
    , input[4:0] WriteRegM //forward (ALU -- ALU)
    , input[4:0] WriteRegW //forward (MEM -- ALU)
    , input PCSrcD //for flush if branch
    , input JumpRegF //stall for jr
    , input JumpD //flush for j, jal
    , input BranchF //stall for load --> branch
    , input MemtoRegD //
    , input MemtoRegE //stall for load --> ALU or load --> branch/jr
    , input RegWriteD //stall for alu --> branch/jr
    , input RegWriteM //forward for ALUResult --> ALU
    , input RegWriteW //forward for MemResult --> ALU
    //output
    , output reg[1:0] ForwardAD
    , output reg[1:0] ForwardBD
    , output reg[1:0] ForwardAE
    , output reg[1:0] ForwardBE
    , output reg StallF
    , output reg FlushD
);

//forwarding unit

always @(*) begin
  //EX stage forward
  if (RegWriteM & (WriteRegM != 5'b0) & (WriteRegM == RsE)) begin
    ForwardAE <= 2'b10;
  end
  else if (RegWriteW & (WriteRegW != 5'b0) & (WriteRegW == RsE)) begin
    ForwardAE <= 2'b01;
  end
  else ForwardAE <= 2'b00;

  if (RegWriteM & (WriteRegM != 5'b0) & (WriteRegM == RtE)) begin
    ForwardBE <= 2'b10;
  end
  else if (RegWriteW & (WriteRegW != 5'b0) & (WriteRegW == RtE)) begin
    ForwardBE <= 2'b01;
  end
  else ForwardBE <= 2'b00;

  //ID stage forward
  if (RegWriteM & (WriteRegM != 5'b0) & (WriteRegM == RsD)) begin
    ForwardAD <= 2'b10;
  end
  else if (RegWriteW & (WriteRegW != 5'b0) & (WriteRegW == RsD)) begin
    ForwardAD <= 2'b01;
  end
  else begin
    ForwardAD <= 2'b00;
  end

  if (RegWriteM & (WriteRegM != 5'b0) & (WriteRegM == RtD)) begin
    ForwardBD <= 2'b10;
  end
  else if (RegWriteW & (WriteRegW != 5'b0) & (WriteRegW == RtD)) begin
    ForwardBD <= 2'b01;
  end
  else begin
    ForwardBD <= 2'b00;
  end

  //flush for branch (assume not taken)
  //if branch/jump, then we flush ID/EX register (wrong instr)
  //assign FlushD = ((PCSrcD | JumpD) === 1)? 1'b1: 1'b0;

  //stall unit
  if (
    (MemtoRegD & (WriteRegD!=5'b0) & ((RSDpdF & (WriteRegD==RsF))|(RTDpdF & (WriteRegD==RtF))))
    |
    (MemtoRegE & (WriteRegE!=5'b0) & (BranchF|JumpRegF) & ((RSDpdF & (WriteRegE==RsF))|(RTDpdF & (WriteRegE==RtF))))
    |
    (RegWriteD & (WriteRegD!=5'b0) & (BranchF|JumpRegF) & ((RSDpdF & (WriteRegD==RsF))|(RTDpdF & (WriteRegD==RtF))) )
    )  begin
    StallF <= 1'b1;
  end
  else begin
    StallF <= 1'b0;
  end

  if (
    (MemtoRegD & (WriteRegD!=5'b0) & ((RSDpdF & (WriteRegD==RsF))|(RTDpdF & (WriteRegD==RtF))))
    |
    (MemtoRegE & (WriteRegE!=5'b0) & (BranchF|JumpRegF) & ((RSDpdF & (WriteRegE==RsF))|(RTDpdF & (WriteRegE==RtF))))
    |
    (RegWriteD & (WriteRegD!=5'b0) & (BranchF|JumpRegF) & ((RSDpdF & (WriteRegD==RsF))|(RTDpdF & (WriteRegD==RtF))) )
    | (PCSrcD | JumpD) === 1
    )  begin
    FlushD <= 1'b1;
  end
  else begin
    FlushD <= 1'b0;
  end
end






endmodule