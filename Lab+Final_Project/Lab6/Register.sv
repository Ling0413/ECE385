module Register # (N = 1) 
(
	input 	logic				Clk,
	input		logic				Load,
	input		logic				Reset,
	input		logic[N-1:0]	Din,
	output	logic[N-1:0]	Dout
);


	always_ff @ (posedge Clk)
		begin
				if (Reset)
					Dout <= 0;
				else if (Load)
					Dout <= Din;
		end

endmodule 