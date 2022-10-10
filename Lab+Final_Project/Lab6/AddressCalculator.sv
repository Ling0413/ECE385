module AddressCalculator
(
	input		logic				ADDR1MUX,
	input		logic[1:0]		ADDR2MUX,
	input 	logic[15:0]		IR, from_PC, from_RF, 
	output	logic[15:0]		AC_out
);

	logic[15:0] ADDR2;
	logic[15:0] ADDR1;
	assign AC_out = ADDR1 + ADDR2;
	
	always_comb
	begin
			case(ADDR1MUX)
				1'b0:
						ADDR1 = from_PC;
				1'b1:
						ADDR1 = from_RF;
			endcase
		
			case(ADDR2MUX)
				2'b00:
						ADDR2 = 16'b0;
				2'b01:
						ADDR2 = {{10{IR[5]}},IR[5:0]};
				2'b10:
						ADDR2 = {{7{IR[8]}},IR[8:0]};
				2'b11:
						ADDR2 = {{5{IR[10]}},IR[10:0]};
			endcase
	end

endmodule 