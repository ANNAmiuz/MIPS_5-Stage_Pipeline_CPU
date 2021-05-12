module EX_MEM(
    //input
      input[31:0] ALUOutE
    , input[31:0] WriteDataE
    , input[4:0] WriteRegE
    , input RegWriteE
    , input MemtoRegE
    , input MemWriteE
    , input clk
    , input[31:0] returnAddressE
    , input[5:0] opcodeE
    , input[31:0] instrE
    , output reg[31:0] ALUOutM
    , output reg[31:0] WriteDataM
    , output reg[4:0] WriteRegM
    , output reg RegWriteM
    , output reg MemtoRegM
    , output reg MemWriteM
    , output reg[31:0] returnAddressM
    , output reg[5:0] opcodeM
    , output reg[31:0] instrM
);

always @(posedge clk) begin
    ALUOutM <= ALUOutE;
    WriteDataM <= WriteDataE;
    WriteRegM <= WriteRegE;
    RegWriteM <= RegWriteE;
    MemtoRegM <= MemtoRegE;
    MemWriteM <= MemWriteE;
    returnAddressM <= returnAddressE;
    opcodeM <= opcodeE;
    instrM <= instrE;
end


endmodule