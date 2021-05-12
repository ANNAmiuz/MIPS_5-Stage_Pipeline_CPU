module PCReg(
    //input
      input[31:0] PC
    , input enable
    , input clk
    , input reset
    //output
    , output reg[31:0] PCF
);


  always @(posedge clk) begin
      if (reset != 1'b0) PCF <= 32'b0;
      else if (enable == 1'b0) PCF <= PC;
  end

endmodule