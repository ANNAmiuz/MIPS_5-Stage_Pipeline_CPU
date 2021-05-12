module JumpUnit(
    //input
      input[25:0] instr_address
    , input[31:0] PCPlus4D
    , input JumpRegD
    , input[31:0] reg_address
    //output
    , output[31:0] JumpTargetD
    , output[31:0] returnAddressD
);

assign JumpTargetD = (JumpRegD===1)? reg_address:{{PCPlus4D[31:28]}, {instr_address[25:0]}, {2{1'b0}}};
assign returnAddressD = PCPlus4D;

endmodule