module PC
(
	input		logic				LD_PC,
	input		logic				Reset,
	input		logic				Clk,
	input		logic[1:0]		PCMUX,
	input 	logic[15:0]		from_bus,
	input		logic[15:0]		from_AC,		// address from Address Calculator
	output	logic[15:0]		PC_out
);
	
	logic[15:0]	in_PC;
	
	always_comb 
	begin
		  case(PCMUX)
					 2'b00:
							  in_PC = PC_out + 1;
					 2'b01:
							  in_PC = from_bus;
					 2'b10:
							  in_PC = from_AC;
					 default:
							  in_PC = {16{1'bZ}};
			endcase
	end
				
	always_ff @ (posedge Clk)
	begin
			if (Reset)
				PC_out <= 16'h0000;
			else if (LD_PC)
				PC_out <= in_PC;
			else
				PC_out <= PC_out;
	end


endmodule 
