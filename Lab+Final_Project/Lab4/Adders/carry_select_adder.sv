module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  // Define some internal wires for carry out signals
	  logic C4, C8, C12;
	  
	  // Implement 16-bits CAS adders using 4-bits CAS adders and a 4-bits ripple adder
	  FourBits_ripple_adder Fra0(.x(A[ 3: 0]), .y(B[ 3: 0]), .cin(  0), .s(Sum[ 3: 0]), .cout( C4));
	  FourBits_CAS_adder 	FCa1(.A(A[ 7: 4]), .B(B[ 7: 4]), .Cin( C4), .S(Sum[ 7: 4]), .Cout( C8));
	  FourBits_CAS_adder 	FCa2(.A(A[11: 8]), .B(B[11: 8]), .Cin( C8), .S(Sum[11: 8]), .Cout(C12));
	  FourBits_CAS_adder 	FCa3(.A(A[15:12]), .B(B[15:12]), .Cin(C12), .S(Sum[15:12]), .Cout( CO));
     
endmodule




// 4-bits CAS adder (not the lowest significant group)
module FourBits_CAS_adder
(
	input		logic[3:0]	A,
	input		logic[3:0]	B,
	input		logic			Cin,
	output	logic[3:0]	S,
	output	logic			Cout
);
	
	// Define some internal wires for selection and carry out signals
	logic [3:0] S0, S1;
	logic C0, C1;
	
	// Connect the I/O pins of two ripple adders
	FourBits_ripple_adder Fra0(.x(A), .y(B), .cin(0), .s(S0), .cout(C0));
	FourBits_ripple_adder Fra1(.x(A), .y(B), .cin(1), .s(S1), .cout(C1));
	
	// The selection part (Mux) of circuit
	always_comb begin
		
		Cout = (C1 & Cin) | C0;
		
		if (Cin)
			S = S1;
		else
			S = S0;
	
	end
	
endmodule




// 4-bits ripple adder (same as previous ripple adder)
module FourBits_ripple_adder
(
	input [3:0] x,
	input [3:0] y,
	input cin,
	output logic [3:0] s,
	output logic cout
);

	logic c0, c1, c2;

	full_adder_b fa0(.x(x[0]), .y(y[0]), .cin(cin), .s(s[0]), .cout(  c0));
	full_adder_b fa1(.x(x[1]), .y(y[1]), .cin( c0), .s(s[1]), .cout(  c1));
	full_adder_b fa2(.x(x[2]), .y(y[2]), .cin( c1), .s(s[2]), .cout(  c2));
	full_adder_b fa3(.x(x[3]), .y(y[3]), .cin( c2), .s(s[3]), .cout(cout));

endmodule




// 1-bit full adder (same as previous full adder)
module full_adder_b
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