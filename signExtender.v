module signExtender (
    //input
      input[15:0] immediate
    //output
    , output[31:0] extendedResult
);

assign extendedResult = {{16{immediate[15]}},immediate};
    
endmodule