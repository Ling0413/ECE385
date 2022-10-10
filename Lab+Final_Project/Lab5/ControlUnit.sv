// Control unit
module control_unit
(
		input		logic		Clk, 
		input		logic		Reset,
		input		logic		Run,
		input		logic		ClearA_LoadB,
		input 	logic		M,  // the least significant bit of register B
		
		output	logic		Clr_Ld,
		output	logic		Shift,
		output	logic		Add,
		output	logic		Sub,
		output 	logic		rs,  // reset signal which clear all the registers
		output	logic    rsA   // reset signal that clear A and X
);

	// Define states, Excu_i0 calculates the value, Excu_i1 shift the register
	enum logic[4:0]	{Excu_10, Excu_20, Excu_30, Excu_40, Excu_50, Excu_60, Excu_70, Excu_80, 
							 Excu_11, Excu_21, Excu_31, Excu_41, Excu_51, Excu_61, Excu_71, Excu_81, 
							 Init, Halt, Media, ClearA}		curr_state, next_state;
	
	// State assignment
	always_ff @ (posedge Clk)
	begin
			if (Reset)
				curr_state <= Init;
			else
				curr_state <= next_state;
	end
	
	// State transition
	always_comb
	begin
			next_state = curr_state;
			
			unique case (curr_state)
			
				Init: if (ClearA_LoadB)
							next_state = Media;
				
				Media: if (Run)
							next_state = ClearA;
				
				ClearA: next_state = Excu_10;
				
				Excu_10:	next_state = Excu_11;
				Excu_11:	next_state = Excu_20;
				
				Excu_20:	next_state = Excu_21;
				Excu_21:	next_state = Excu_30;
				
				Excu_30:	next_state = Excu_31;
				Excu_31:	next_state = Excu_40;
				
				Excu_40:	next_state = Excu_41;
				Excu_41:	next_state = Excu_50;
				
				Excu_50:	next_state = Excu_51;
				Excu_51:	next_state = Excu_60;
				
				Excu_60:	next_state = Excu_61;
				Excu_61:	next_state = Excu_70;
				
				Excu_70:	next_state = Excu_71;
				Excu_71:	next_state = Excu_80;
				
				Excu_80:	next_state = Excu_81;
				Excu_81:	next_state = Halt;
				
				Halt: if (~Run)
							next_state = Media;
				
				
				
			endcase
	end
	
	// Output of each state
	always_comb
	begin
			
			Clr_Ld = ClearA_LoadB;
			Shift  = 0;
			Add    = 0;
			Sub    = 0;
			rs     = 0;
			rsA    = 0;
			
			case (curr_state)

				Init: rs = 1;
				
				ClearA: rsA = 1;
				
				Excu_10:
					begin
						if (M)
							Add = 1;		// add S to A if last signficant bit of B is 1
						else
							Add = 0;
					end
				
				Excu_20:
					begin
						if (M)
							Add = 1;
						else
							Add = 0;
					end
					
				Excu_30:
					begin
						if (M)
							Add = 1;
						else
							Add = 0;
					end
				
				Excu_40:
					begin
						if (M)
							Add = 1;
						else
							Add = 0;
					end
				
				Excu_50:
					begin
						if (M)
							Add = 1;
						else
							Add = 0;
					end
				
				Excu_60:
					begin
						if (M)
							Add = 1;
						else
							Add = 0;
					end
				
				Excu_70:
					begin
						if (M)
							Add = 1;
						else
							Add = 0;
					end
				
				Excu_80:
					begin
						if (M)
							Sub = 1;
						else
							Sub = 0;
					end
				
				Excu_11:	Shift = 1;
				Excu_21:	Shift = 1;
				Excu_31:	Shift = 1;
				Excu_41:	Shift = 1;
				Excu_51:	Shift = 1;
				Excu_61:	Shift = 1;
				Excu_71:	Shift = 1;
				Excu_81:	Shift = 1;
				
				endcase
	end


endmodule 