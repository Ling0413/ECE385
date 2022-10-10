// 8-bit 2's compliment multiplier
module multiplier
(
		input		logic				Clk, 
		input		logic				Reset,
		input		logic				Run,
		input		logic				ClearA_LoadB,
		input		logic[7:0]		S,
		
		output	logic				X,
		output	logic[7:0]		Aval,
		output	logic[7:0]		Bval
);
	
	
	
	// Declare internal wires
	// For control unit
	logic 			Clr_Ld, Shift, Add, Sub, rs, rsA;
	// For registers
	logic				Aout, Bout, Aload, Bload;
	logic[7:0]		Bin8;
	// For adder
	logic[8:0]		Sum;
	logic[7:0]		RAin_A, RAin_B;
	logic				sub;
	
	// Use a register to store X
	always_ff @ (posedge Clk)
	begin
			if (Aload)
				X <= Sum[8];
	end

	
	// Control unit
	control_unit  CU(.Clk, .Reset, .Run, .ClearA_LoadB, .M(Bval[0]), .Clr_Ld, .Shift, .Add, .Sub, .rs, .rsA);
	
	// Two shift registers
	shift_register  SRA(.Clk, .Shift_En(Shift), .Shift_In(X)   , .Load(Aload), .Din(Sum[7:0]), .Shift_Out(Aout), .Dout(Aval));
	shift_register  SRB(.Clk, .Shift_En(Shift), .Shift_In(Aout), .Load(Bload), .Din(Bin8)    , .Shift_Out(Bout), .Dout(Bval));
	
	// Adder
	adder_substractor  AS(.A(RAin_A), .B(RAin_B), .fn(sub), .Sum);

	// Control data loading and calculation
	always_comb
	begin
			
			
			
			if (Clr_Ld) begin  // If ClearA_LoadB is pressed
				Aload  = 1;
				Bload  = 1;
				sub = 0;
				RAin_A = 8'b00000000;
				RAin_B = 8'b00000000;
				Bin8   = S;
			end
			else if (rs) begin   // Reset is A, B and X
				Aload  = 1;
				Bload  = 1;
				sub = 0;
				RAin_A = 8'b00000000;
				RAin_B = 8'b00000000;
				Bin8   = 8'b00000000;
			end
			else if (rsA) begin  // Reset A and X
				Aload  = 1;
				Bload  = 0;
				sub = 0;
				RAin_A = 8'b00000000;
				RAin_B = 8'b00000000;
				Bin8   = S;
			end
			else if (Add) begin  // Add S to A
				Aload  = 1;
				Bload  = 0;
				sub = 0;
				RAin_A = Aval;
				RAin_B = S;
				Bin8   = S;
			end
			else if (Sub) begin   // Calculate A-S
				Aload  = 1;
				Bload  = 0;
				sub = 1;
				RAin_A = Aval;
				RAin_B = S;
				Bin8   = S;
			end
			else begin
				Aload  = 0;
				Bload  = 0;
				sub = 0;
				RAin_A = Aval;
				RAin_B = S;
				Bin8   = S;
			end
	end
	
endmodule 