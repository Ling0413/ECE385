module Bus
(
	input		logic				GatePC, GateMDR, GateALU, GateMARMUX,				
	input 	logic[15:0]		from_MARMUX, from_PC, from_MDR, from_ALU,	
	output	logic[15:0]		bus_out		
);
	
	always_comb
	begin
			if (GatePC == 1)
				bus_out = from_PC;
			else if (GateMDR == 1)
				bus_out = from_MDR;
			else if (GateALU == 1)
				bus_out = from_ALU;
			else if (GateMARMUX == 1)
				bus_out = from_MARMUX;
			else
				bus_out = 16'bZ;
	end
	
endmodule 