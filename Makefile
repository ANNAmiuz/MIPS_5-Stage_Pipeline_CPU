test:compile; vvp compiled;
compile: adder32.v ALU.v controlUnit.v CPU.v EXMEM.v hazard_unit.v IDEX.v IFID.v InstructionRAM.v jumpUnit.v MainMemory.v MEMWB.v PCReg.v regFile.v signExtender.v test_CPU.v; 
			iverilog -o compiled adder32.v ALU.v controlUnit.v CPU.v EXMEM.v hazard_unit.v IDEX.v IFID.v InstructionRAM.v jumpUnit.v MainMemory.v MEMWB.v PCReg.v regFile.v signExtender.v test_CPU.v;
