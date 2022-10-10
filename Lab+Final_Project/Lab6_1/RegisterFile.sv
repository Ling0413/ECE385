module RegisterFile
(
	input 	logic				Clk,
	input 	logic				DRMUX, SR1MUX, LD_REG, 
	input		logic[15:0]		from_bus, from_IR,
	output	logic[15:0]		SR1_out, SR2_out
//	output	logic[15:0]    test1, test2, test3, test4, test5, test6, test7, test8
);

	logic[15:0]		reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
	logic[2:0]		Load_addr, SR1_addr;
	
	
//	//For test
//	assign test1 = reg0;
//	assign test2 = reg1;
//	assign test3 = reg2;
//	assign test4 = reg3;
//	assign test5 = reg4;
//	assign test6 = reg5;
//	assign test7 = reg6;
//	assign test8 = reg7;
	

	always_ff @ (posedge Clk)
	begin
			if (LD_REG) begin
					unique case (Load_addr)
						3'b000: reg0 <= from_bus;
						3'b001: reg1 <= from_bus;
						3'b010: reg2 <= from_bus;
						3'b011: reg3 <= from_bus;
						3'b100: reg4 <= from_bus;
						3'b101: reg5 <= from_bus;
						3'b110: reg6 <= from_bus;
						3'b111: reg7 <= from_bus;
					endcase
			end
	end
	
	// MUX for DR
	always_comb
	begin
			if (DRMUX==0)
				Load_addr = from_IR[11:9];
			else
				Load_addr = 3'b111;
	end
	
	// MUX for SR1
	always_comb
	begin
			if (SR1MUX==0)
				SR1_addr = from_IR[11:9];
			else
				SR1_addr = from_IR[8:6];
	end
	
	// SR1 and SR2 search
	always_comb
	begin
			unique case (SR1_addr)
					3'b000: SR1_out = reg0;
					3'b001: SR1_out = reg1;
					3'b010: SR1_out = reg2;
					3'b011: SR1_out = reg3;
					3'b100: SR1_out = reg4;
					3'b101: SR1_out = reg5;
					3'b110: SR1_out = reg6;
					3'b111: SR1_out = reg7;
			endcase
	end
	
	always_comb
	begin
			unique case (from_IR[2:0])
					3'b000: SR2_out = reg0;
					3'b001: SR2_out = reg1;
					3'b010: SR2_out = reg2;
					3'b011: SR2_out = reg3;
					3'b100: SR2_out = reg4;
					3'b101: SR2_out = reg5;
					3'b110: SR2_out = reg6;
					3'b111: SR2_out = reg7;
			endcase
	end

endmodule 