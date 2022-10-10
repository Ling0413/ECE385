// State machine which controls the I/O of memory

module StateMachine(
	input  logic	Clk,
	input  logic 	Reset,
	input  logic 	Address_flag,
	input  logic	VGA_CLK,
	output logic	MIMO_in_enable,
	output logic	MIMO_out_enable,
	output logic	Is_background
);
	
	// Declaration of states
	enum
	
	// 2-always state machine
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end

endmodule 