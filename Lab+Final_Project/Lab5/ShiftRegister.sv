// N-bit Shift register
module shift_register #(N=8)
(
		input		logic				Clk, 
		input		logic				Shift_En,
		input		logic				Shift_In,
		input		logic				Load,
		input		logic[N-1:0]	Din,
		
		output	logic				Shift_Out,
		output	logic[N-1:0]	Dout
);

	always_ff @ (posedge Clk)
	begin
			if (Load)
				Dout <= Din;
			else if (Shift_En)
				Dout <= {Shift_In, Dout[N-1:1]};
			else
				Dout <= Dout;
	end
	
	assign Shift_Out = Dout[0];

endmodule 