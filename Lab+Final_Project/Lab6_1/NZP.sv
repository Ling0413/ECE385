module NZP
(
	input 	logic				Clk,
	input 	logic				Reset,
	input 	logic				LD_CC, LD_BEN, 
	input		logic[15:0]		from_bus, from_IR,
	output	logic				BEN
//	output 	logic				test_n, test_z, test_p		// For test
);
	
	logic		n, z, p;
	
//	// For test
//	assign test_n = n;
//	assign test_z = z;
//	assign test_p = p;
	
	always_ff @ (posedge Clk)
	begin
			if (Reset)
			begin
				n <= 0;
				z <= 0;
				p <= 0;
			end
			else if (LD_CC)
			begin
					if (from_bus[15] == 1)
					begin
							n <= 1;
							z <= 0;
							p <= 0;
					end
					else if (from_bus == 16'b0)
					begin
							n <= 0;
							z <= 1;
							p <= 0;
					end
					else
					begin
							n <= 0;
							z <= 0;
							p <= 1;
					end
			end
	end
	
	always_ff @ (posedge Clk)
	begin 
			if (Reset)
				BEN <= 0;
			else if (LD_BEN)
				BEN <= (from_IR[11] & n) | (from_IR[10] & z) | (from_IR[9] & p);
	end

endmodule 