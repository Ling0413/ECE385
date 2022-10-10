// Top-level circuit of lab5
module lab5_toplevel
(
		input		logic				Clk, 
		input		logic				Reset,
		input		logic				Run,
		input		logic				ClearA_LoadB,
		input		logic[7:0]		S,
		
		output	logic				X,
		output	logic[7:0]		Aval,
		output	logic[7:0]		Bval,
		output   logic[6:0] 		AhexL, 
		output   logic[6:0] 		AhexU, 
		output   logic[6:0] 		BhexL, 
		output   logic[6:0] 		BhexU
);

	

	// Declare internal wires  
   logic[6:0] 		AhexL_comb;
   logic[6:0] 		AhexU_comb;
	logic[6:0] 		BhexL_comb;
	logic[6:0] 		BhexU_comb;
	
	// Connect multiplier to the circuit
	multiplier M_inst(.Clk, .Reset(!Reset), .Run(!Run), .ClearA_LoadB(!ClearA_LoadB), .S, .X, .Aval, .Bval);

	// Wiring up output signals
	always_ff @(posedge Clk) begin
	  
	  AhexL <= AhexL_comb;
	  AhexU <= AhexU_comb;
	  BhexL <= BhexL_comb;
	  BhexU <= BhexU_comb;
	  
	end
		
	HexDriver Ahex0_inst(.In0(Aval[3:0]), .Out0(AhexL_comb));
	HexDriver Ahex1_inst(.In0(Aval[7:4]), .Out0(AhexU_comb));
	
	HexDriver Bhex0_inst(.In0(Bval[3:0]), .Out0(BhexL_comb));
	HexDriver Bhex1_inst(.In0(Bval[7:4]), .Out0(BhexU_comb));
	 
endmodule 