// 9-bit adder-substractor
// When fn=1, perform substraction; when fn=0, perform addition
module adder_substractor
(
		 input   logic[7:0]     A,
		 input   logic[7:0]     B,
		 input	logic				fn,
		 output  logic[8:0]     Sum
);
	  
	  // Define some internal wires for carry out signals
	  logic 			c0, c1, c2, c3, c4, c5, c6, c7;
	  logic[7:0] 	BB;
	  logic 			A8, BB8;
	  
	  assign BB = (B ^ {8{fn}});
	  assign A8 = A[7];
	  assign BB8 = BB[7];
	  
	  // Implement 9-bit adder using 1-bit full adders
	  full_adder  fa0(.x(A[0]), .y(BB[0]), .cin(fn), .s(Sum[0]), .cout(c0));
	  full_adder  fa1(.x(A[1]), .y(BB[1]), .cin(c0), .s(Sum[1]), .cout(c1));
	  full_adder  fa2(.x(A[2]), .y(BB[2]), .cin(c1), .s(Sum[2]), .cout(c2));
	  full_adder  fa3(.x(A[3]), .y(BB[3]), .cin(c2), .s(Sum[3]), .cout(c3));
	  full_adder  fa4(.x(A[4]), .y(BB[4]), .cin(c3), .s(Sum[4]), .cout(c4));
	  full_adder  fa5(.x(A[5]), .y(BB[5]), .cin(c4), .s(Sum[5]), .cout(c5));
	  full_adder  fa6(.x(A[6]), .y(BB[6]), .cin(c5), .s(Sum[6]), .cout(c6));
	  full_adder  fa7(.x(A[7]), .y(BB[7]), .cin(c6), .s(Sum[7]), .cout(c7));
	  
	  full_adder  faS(.x(A8), .y(BB8), .cin(c7), .s(Sum[8]), .cout());
	  

endmodule



// 1-bit full adder
module full_adder
(
	input x,
	input y,
	input cin,
	output logic s,
	output logic cout
);
	
	assign s = x ^ y ^ cin;
	assign cout = (x & y) | (y & cin) | (x & cin);

endmodule 