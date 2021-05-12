module Adder32 (
    //input
      input[31:0] operandA
    , input[31:0] operandB
    //output
    , output [31:0] result
);

assign result = operandA + operandB;
    
endmodule