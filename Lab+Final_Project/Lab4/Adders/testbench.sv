module testbench();

timeunit 10ns;

timeprecision 1ns;

	logic           Clk;        // 50MHz clock is only used to get timing estimate data
	logic           Reset;      // From push-button 0.  Remember the button is active low (0 when pressed)
	logic           LoadB;      // From push-button 1
	logic           Run;        // From push-button 3.
	logic[15:0]     SW;         // From slider switches
	 
	// all outputs are registered
	logic           CO;         // Carry-out.  Goes to the green LED to the left of the hex displays.
	logic[15:0]     Sum;        // Goes to the red LEDs.  You need to press "Run" before the sum shows up here.
	logic[6:0]      Ahex0;      // Hex drivers display both inputs to the adder.
	logic[6:0]      Ahex1;
	logic[6:0]      Ahex2;
	logic[6:0]      Ahex3;
	logic[6:0]      Bhex0;
	logic[6:0]      Bhex1;
	logic[6:0]      Bhex2;
	logic[6:0]      Bhex3;
	
	// To store expected results
	logic [15:0] ans_1, ans_2, ans_3, ans_4, ans_5;

	
	always begin : CLOCK_GENERATION
	#1 Clk = ~Clk;
	end
	
	initial begin : CLOCK_INITIALIZATION
		Clk = 0;
	end 
	
	
	lab4_adders_toplevel tp(.*);
	
	
	initial begin: TEST_VECTORS
		Reset = 0;
		LoadB = 1;
		Run 	= 1;
		
	// Test case1: A = 0001, B = 0002
	// Expected result: Sum = 0003, CO = 0
	#2 Reset = 1;
	#2 LoadB = 0;
		SW = 16'h0001;
	#2 LoadB = 1;
		SW = 16'h0002;
	#2 Run = 0;
	
	#20;
	ans_1 = 16'h0003;
	if ((Sum != ans_1) | (CO != 0))
		$display("Case 1 failed!");
	else
		$display("Case 1 passed!");
	Reset = 0;
	Run 	= 1;
	
	// Test case2: A = 03A8, B = 01E9
	// Expected result: Sum = 0591, CO = 0
	#2 Reset = 1;
	#2 LoadB = 0;
		SW = 16'h01E9;
	#2 LoadB = 1;
		SW = 16'h03A8;
	#2 Run = 0;
	
	#20;
	ans_2 = 16'h0591;
	if ((Sum != ans_2) | (CO != 0))
		$display("Case 2 failed!");
	else
		$display("Case 2 passed!");
	Reset = 0;
	Run 	= 1;
	
	
	// Test case3: A = F232, B = 14DB
	// Expected result: Sum = 070D, CO = 1
	#2 Reset = 1;
	#2 LoadB = 0;
		SW = 16'h14DB;
	#2 LoadB = 1;
		SW = 16'hF232;
	#2 Run = 0;
	
	#20;
	ans_3 = 16'h070D;
	if ((Sum != ans_3) | (CO != 1))
		$display("Case 3 failed!");
	else
		$display("Case 3 passed!");
	Reset = 0;
	Run 	= 1;
	
	
	// Test case4: A = FFFF, B = 0001
	// Expected result: Sum = 0000, CO = 1
	#2 Reset = 1;
	#2 LoadB = 0;
		SW = 16'h0001;
	#2 LoadB = 1;
		SW = 16'hFFFF;
	#2 Run = 0;
	
	#20;
	ans_4 = 16'h0000;
	if ((Sum != ans_4) | (CO != 1))
		$display("Case 4 failed!");
	else
		$display("Case 4 passed!");
	Reset = 0;
	Run 	= 1;
	
	
	// Test case5: A = F8F0, B = C8F0
	// Expected result: Sum = C1E0, CO = 1
	#2 Reset = 1;
	#2 LoadB = 0;
		SW = 16'hC8F0;
	#2 LoadB = 1;
		SW = 16'hF8F0;
	#2 Run = 0;
	
	#20;
	ans_5 = 16'hC1E0;
	if ((Sum != ans_5) | (CO != 1))
		$display("Case 5 failed!");
	else
		$display("Case 5 passed!");
	
	
	end


endmodule
	