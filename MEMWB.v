module MEM_WB
(
    //input
      input clk
    , input RegWriteM
    , input MemtoRegM
    , input[31:0] ReadDataM
    , input[31:0] ALUOutM
    , input[4:0] WriteRegM
    , input[31:0] returnAddressM
    , input[5:0] opcodeM
    , input[31:0] instrM
    //output
    , output reg RegWriteW
    , output reg MemtoRegW
    , output reg[31:0] ReadDataW
    , output reg[31:0] ALUOutW
    , output reg[4:0] WriteRegW
    , output reg[31:0] returnAddressW
    , output reg[5:0] opcodeW
    , output reg[31:0] instrW
);

always @(posedge clk) begin
    RegWriteW <= RegWriteM;
    MemtoRegW <= MemtoRegM;
    ReadDataW <= ReadDataM;
    ALUOutW <= ALUOutM;
    WriteRegW <= WriteRegM;
    returnAddressW <= returnAddressM;
    opcodeW <= opcodeM;
    instrW <= instrM;
end

endmodule

