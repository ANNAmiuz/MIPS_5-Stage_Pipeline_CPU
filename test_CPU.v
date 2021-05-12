`timescale 1ns/1ns

module CPU_test;

//period initialization
parameter clk_period = 10;  
reg clk, reset;  
integer i;

//module instantiation
CPU testedCPU(
              .CLK(clk)
            , .reset(reset)
            );

initial begin  
    clk = 0; 
    #1 reset = 1'b1;
    #(clk_period / 2) clk = ~clk;
    #1 reset = 1'b0;
    //testedCPU.instrW
    while (testedCPU.instrW !== 32'hffff_ffff) begin
        #(clk_period / 2) clk = ~clk;
        if((testedCPU.instrF==32'b00100000000000100000000001010100)||(testedCPU.instrD==32'b00100000000000100000000001010100)||(testedCPU.instrE==32'b00100000000000100000000001010100)||(testedCPU.instrM==32'b00100000000000100000000001010100)||(testedCPU.instrW==32'b00100000000000100000000001010100)) begin
            //$display("PC, %d", (testedCPU.PC>>2));
            //#2
            //$display("PCF, %d", (testedCPU.PCF>>2));
            // jump branch test module
            // $display("PC, %d", (testedCPU.PC>>2));
            // $display("JumpF, %b", testedCPU.JumpF);
            // $display("targetF , %b", testedCPU.instrF[25:0]);
            // $display("PCPlus4F, %b", testedCPU.PCPlus4F);
            // $display("PCPlus4D, %b", testedCPU.PCPlus4D);
            // $display("JumpRegD, %b", testedCPU.JumpRegD);
            // $display("JumpTargetD, %d", (testedCPU.JumpTargetD>>2));
            // $display("inner targetD, %b", testedCPU.JumpUnitD.JumpTargetD);
            // $display("inner judge, %b", testedCPU.JumpUnitD.JumpRegD);
            // $display("JumpD, %b", testedCPU.JumpD);
            // $display("PCSrcD, %b", testedCPU.PCSrcD);
            
            //register and alu operation test module
            // $display("regRD1D, %b", testedCPU.regRD1D);
            // $display("regRD2D, %b", testedCPU.regRD2D);
            // $display("regRD1E, %b", testedCPU.regRD1E);
            // $display("regRD2E, %b", testedCPU.regRD2E);
            // $display("SrcAE, %b", testedCPU.SrcAE);
            // $display("SrcBE, %b", testedCPU.SrcBE);
            // $display("ALUOutE, %b", testedCPU.ALUOutE);
            // $display("WriteDataE, %b", testedCPU.WriteDataE);
            // $display("WriteDataM, %b", testedCPU.WriteDataM);
            // $display("ResultW, %b", testedCPU.ResultW);
            // $display("register file");
            // for (i = 0; i < 32; i++) begin
            //     $display("%b", testedCPU.registers.register[i]);
            // end

            //hazard solution test module
            // $display("opcode, %b", testedCPU.instrF[31:26]);
            // $display("funct, %b", testedCPU.instrF[5:0]);
            // $display("BranchF, %b", testedCPU.FlushD);
            // $display("JumpRegF, %b", testedCPU.FlushD);
            // $display("StallF, %b", testedCPU.StallF);
            // $display("JumpRegF, %b", testedCPU.JumpRegF);
            // $display("RsF, %b", testedCPU.RsF);
            // $display("RtF, %b", testedCPU.RtF);
            // $display("RSDpdF, %b", testedCPU.RSDpdF);
            // $display("RTDpdF, %b", testedCPU.RTDpdF);
            // $display("FlushD, %b", testedCPU.FlushD);
            // $display("PCSrcD, %b", testedCPU.PCSrcD);
            // $display("JumpD, %b", testedCPU.JumpD);
            // $display("RegWriteD, %b", testedCPU.RegWriteD);
            // $display("WriteRegD, %d", testedCPU.WriteRegD);
            // $display("JumpRegD, %b", testedCPU.JumpRegD);
            // $display("jr_address, %d", testedCPU.data1);
            

            // $display("SignImmeE, %d", testedCPU.SignImmeE);
            // $display("fetch address, %d", testedCPU.ALUOutM);
            // $display("ReadDataM, %b", testedCPU.ReadDataM);
            // $display("data in lw address, %b", testedCPU.dataMem.DATA_RAM[testedCPU.ReadDataM>>2]);
            // $display("ReadDataW, %b", testedCPU.ReadDataW);
            //$display("\n");
        end
        
    end
    $display("main memory");
    for (i = 0; i < 512; i++) begin
        $display("%b", testedCPU.dataMem.DATA_RAM[i]);
    end
    $display("\n");
    // $display("final register file:");
    // for (i = 0; i < 32; i++) begin
    //     $display("%b", testedCPU.registers.register[i]);
    // end
    $finish;
end
endmodule
