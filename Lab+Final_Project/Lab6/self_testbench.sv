module self_testbench();

timeunit 10ns;

timeprecision 1ns;

	logic		Clk;

	
	/*==========BUS==========*/
	
	
//	// Input
//	logic				GatePC;
//	logic				GateMDR;
//	logic				GateALU;
//	logic				GateMARMUX;
//	logic[15:0]		from_MARMUX;
//	logic[15:0]		from_PC;
//	logic[15:0]		from_MDR;
//	logic[15:0]		from_ALU;
//	
//
//	// Output
//	logic[15:0]		bus_out;
//
//	
//	always begin : CLOCK_GENERATION
//	#1 Clk = ~Clk;
//	end
//	
//	initial begin : CLOCK_INITIALIZATION
//		Clk = 0;
//	end 
//	
//	
//	Bus Bus1(.*);
//	
//	
//	initial begin: TEST_VECTORS
//		GatePC = 0;
//		GateMDR = 0;
//		GateALU = 0;
//		GateMARMUX = 0;
//		
//		from_MARMUX = 16'h01;
//		from_PC = 16'h02;
//		from_MDR = 16'h03;
//		from_ALU = 16'h04;
//		
//	
//	// Test case1
//	#10;
//	
//	#10 GateMARMUX = 1;
//	
//	
//	#10 GateMARMUX = 0;
//	GatePC = 1;
//	
//	#10 GatePC = 0;
//	GateMDR = 1;
//	
//	#10 GateMDR = 0;
//	GateALU = 1;
//	
//	#10 GateALU = 0;
//	
//	
//	end

	
	/*==========Register file==========*/
	

//	// Input
//	logic				DRMUX, SR1MUX, LD_REG;
//	logic[15:0]		from_bus, from_IR;
//	
//	// Output
//	logic[15:0]		SR1_out, SR2_out;
//	logic[15:0]		test1, test2, test3, test4, test5, test6, test7, test8;
//
//	
//	always begin : CLOCK_GENERATION
//	#1 Clk = ~Clk;
//	end
//	
//	initial begin : CLOCK_INITIALIZATION
//		Clk = 0;
//	end 
//	
//	
//	RegisterFile RF(.*);
//	
//	
//	initial begin: TEST_VECTORS
//		DRMUX = 0;
//		SR1MUX = 0;
//		LD_REG = 0;
//		from_bus = 16'h0000;
//		from_IR = 16'h0000;
//		
//	
//	// Test case1
//	#10;
//	
//	#4 LD_REG = 1;
//	DRMUX = 0;
//	from_IR = 16'b0000001000000000;		// 0000 |001|0 0000 0000
//	from_bus = 16'h0001;
//	
//	#2 DRMUX = 0;
//	SR1MUX = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	#4 from_IR = 16'b0000010000000000;		// 0000 |010|0 0000 0000
//	from_bus = 16'h0002;
//	
//	#2 DRMUX = 0;
//	SR1MUX = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	#4 from_IR = 16'b0000100000000000;		// 0000 |100|0 0000 0000
//	from_bus = 16'h0003;
//	
//	#2 DRMUX = 0;
//	SR1MUX = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	#4 DRMUX = 1;
//	from_bus = 16'h000A;
//	
//	#10 LD_REG = 0;
//	DRMUX = 0;
//	from_IR = 16'h0000;
//	from_bus = 16'h0000;
//	
//	#4 SR1MUX = 0;
//	from_IR = 16'b0000001000000010;		// 0000 |001|0 0000 0|010
//	
//	#2 DRMUX = 0;
//	SR1MUX = 0;
//	LD_REG = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	#4 from_IR = 16'b0000010000000100;		// 0000 |010|0 0000 0|100
//	
//	#2 DRMUX = 0;
//	SR1MUX = 0;
//	LD_REG = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	#4 from_IR = 16'b0000100000000001;		// 0000 |100|0 0000 0|001
//	
//	#2 DRMUX = 0;
//	SR1MUX = 0;
//	LD_REG = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	#4 SR1MUX = 1;
//	from_IR = 16'b0000000010000111;		// 0000 000|0 10|00 0|111
//	
//	#2 DRMUX = 0;
//	SR1MUX = 0;
//	LD_REG = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	#4 SR1MUX = 0;
//	from_IR = 16'b0000010000000010;		// 0000 |010|0 0000 0|010
//
//	
//	end
	
	
	/*==========NZP==========*/
//	// Input
//	logic				LD_CC, LD_BEN;
//	logic[15:0]		from_bus, from_IR;
//	
//	// Output
//	logic				BEN;
//	logic				test_n, test_z, test_p;
//
//	
//	always begin : CLOCK_GENERATION
//	#1 Clk = ~Clk;
//	end
//	
//	initial begin : CLOCK_INITIALIZATION
//		Clk = 0;
//	end 
//	
//	
//	NZP NZP_inst(.*);
//	
//	
//	initial begin: TEST_VECTORS
//		LD_CC = 0;
//		LD_BEN = 0;
//		from_bus = 16'h0000;
//		from_IR = 16'h0000;
//		
//
//	#10;
//	
//	#4	LD_CC = 1;
//	from_bus = 16'hF000;
//	
//	#2 LD_CC = 0;
//	from_bus = 16'h0000;
//	
//	#4	LD_CC = 1;
//	from_bus = 16'h0000;
//	
//	#2 LD_CC = 0;
//	from_bus = 16'h0000;
//	
//	#4	LD_CC = 1;
//	from_bus = 16'h0001;
//	
//	
//	
//	#10 LD_CC = 0;
//	from_bus = 16'h0000;
//	from_IR = 16'h0000;
//	
//	
//	
//	#4	LD_BEN = 1;
//	from_IR = 16'b0000001000000000;		// 0000 |001|0 0000 0000
//	
//	#4 from_IR = 16'b0000010000000000;		// 0000 |010|0 0000 0000
//	
//	#4	LD_CC = 1;
//	from_bus = 16'hF000;
//	from_IR = 16'b0000100000000000;		// 0000 |100|0 0000 0000
//	
//	end

	
	/*==========PC==========*/
	
//	// Input
//	logic				LD_PC;
//	logic[1:0]		PCMUX;
//	logic[15:0]		from_bus;
//	logic[15:0]		from_AC;	// address from Address Calculator
//	logic				GatePC;
//
//	// Output
//	logic[15:0]		PC_out;
//
//	
//	always begin : CLOCK_GENERATION
//	#1 Clk = ~Clk;
//	end
//	
//	initial begin : CLOCK_INITIALIZATION
//		Clk = 0;
//	end 
//	
//	
//	PC PC1(.*);
//	
//	
//	initial begin: TEST_VECTORS
//		LD_PC = 0;
//		PCMUX = 01;
//		from_bus = 16'h01;
//		from_AC = 16'h02;
//		GatePC = 0;
//		
//		
//	
//	// Test case1
//	#10;
//	
//	#10 LD_PC = 1;
//	
//	
//	#10 PCMUX = 00;
//	
//	#10 PCMUX = 10;
//	
//	#10 PCMUX = 11;
//	
//	end


	/*==========ALU==========*/
//	logic				SR2MUX; 
//	logic[1:0]		ALUK;
//	logic[15:0]		IR, SR2, SR1;			
//	logic[15:0]		ALU_out;
//	ALU ALU1(.*);
//	
//	
//	initial begin: TEST_VECTORS
//		SR2MUX = 0;
//		ALUK = 00;
//		IR = 16'h00dd;
//		SR2 = 16'h00ab;
//		SR1 = 16'h0012;
//	// Test case1
//	#10;
//	
//	#10 SR1 = 16'b1;
//	#10 SR2MUX = 1;
//	#10 SR2MUX = 0;
//		 SR2 = 16'h0001;
//		 SR1 = 16'h0010;
//	#10 ALUK = 01;
//	#10 ALUK = 10;
//	#10 ALUK = 11;
//	
//	
//	
//	end

//
//	/*==========AC==========*/
//	logic				ADDR1MUX;
//	logic[1:0]		ADDR2MUX;
//	logic[15:0]		IR, from_PC, from_RF; 
//	logic[15:0]		AC_out;
//	AddressCalculator AC1(.*);
//	
//	
//	initial begin: TEST_VECTORS
//		ADDR1MUX = 0;
//		ADDR2MUX = 00;
//		IR = 16'h0002;
//		from_PC = 16'h001A;
//		from_RF = 16'h0100;
//	// Test case1
//	#10;
//	#10 from_PC = 16'hFFFF;
//	#10 ADDR2MUX = 01;
//	#10 ADDR2MUX = 10;
//	#10 ADDR2MUX = 11;
//	
//	end
	
endmodule	