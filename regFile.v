module regFile
    (
    //input
      input[4:0] A1
    , input[4:0] A2
    , input[4:0] A3
    , input[31:0] WD3
    , input WE3
    , input clk
    //output
    , output reg[31:0] RD1
    , output reg[31:0] RD2
    );

reg[31:0] register[31:0]; //$zero: register[0]; $at: register[1]......

//registerFile initialization? where are the pointers?
integer i;
initial begin
		for(i = 0; i < 32; i++) begin
			register[i] = 32'b0;
		end
end

//2nd half of the clock to read register data
always @(negedge clk) begin

    RD1 <= register[A1];
    RD2 <= register[A2];    

end

//1st half of the clock to write data to registers
always @(posedge clk) begin
    # 2
    if (((A3 != 4'b0) & WE3)==1) register[A3] <= WD3;
    //#1
    //$display("write by: %b", register[A3]);
end

endmodule