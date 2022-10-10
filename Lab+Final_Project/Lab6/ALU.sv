module ALU
(
	input		logic				SR2MUX, 
	input		logic[1:0]		ALUK,
	input		logic[15:0]		IR, SR2, SR1,			
	output	logic[15:0]		ALU_out
);

	logic[15:0]		MUX_out;
	
	always_comb
	begin
			case(SR2MUX)
					1'b1:
							MUX_out = {{11{IR[4]}},IR[4:0]};
					1'b0:
							MUX_out = SR2;
			endcase
	end

	always_comb
	begin
			case(ALUK)
					2'b00:
							ALU_out = MUX_out + SR1;
					2'b01:
							ALU_out = MUX_out & SR1;
					2'b10:
							ALU_out = ~SR1;
					2'b11:
							ALU_out = SR1;
			endcase
	end

endmodule 