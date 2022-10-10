module Contact (
	input logic Clk,
	input logic Reset,
	input logic contact_singal,
	input logic VGA_VS,
	output logic to_NiosII
);
	
	enum logic [1:0] {contact_0, contact_1, deliver_0, deliver_1} state, next_state;
	
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			state <= contact_0;
		else 
			state <= next_state;
	end
	
	// State transformation
	always_comb
	begin
			
			next_state = state;
			
			unique case (state)
					// No contact
					contact_0:
						begin
							if (VGA_VS == 1'b0)
								next_state = deliver_0;
							if (contact_singal == 1'b1)
								next_state = contact_1;
						end
					// Have contact
					contact_1:
						if (VGA_VS == 1'b0)
							next_state = deliver_1;
					// Deliver 0 to NiosII
					deliver_0:
						if (VGA_VS == 1'b1)
							next_state = contact_0;
					// Deliver 1 to NiosII
					deliver_1:
						if (VGA_VS == 1'b1)
							next_state = contact_0;
					default:
						next_state = contact_0;
			endcase
	end
	
	// State output
	always_comb
	begin
			unique case (state)
					contact_1:
						to_NiosII = 1'b1;
					deliver_1:
						to_NiosII = 1'b1;
					default:
						to_NiosII = 1'b0;
			endcase
	end
	
endmodule 