module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  // Define some internal wires for carry out signals and generating/propagating signals
	  logic C4, C8, C12, P0, P4, P8, P12, G0, G4, G8, G12;
	  
	  // Calculate the carry out values as well as generating/propagating values
	  assign C4  = G0;
	  assign C8  = G4 | (G0 & P4);
	  assign C12 = G8 | (G4 & P8) |(G0 & P8 & P4);
	  assign CO  = G12 | (G8 & P12) | (G4 & P12 & P8) | (G0 & P12 & P8 & P4);
	  
	  // Implement 16-bits CLA adder using 4-bits CLA adders
	  FourBits_CLA_adder FCa0(.A(A[ 3: 0]), .B(B[ 3: 0]), .Cin(  0), .S(Sum[ 3: 0]), .P( P0), .G( G0));
	  FourBits_CLA_adder FCa1(.A(A[ 7: 4]), .B(B[ 7: 4]), .Cin( C4), .S(Sum[ 7: 4]), .P( P4), .G( G4));
	  FourBits_CLA_adder FCa2(.A(A[11: 8]), .B(B[11: 8]), .Cin( C8), .S(Sum[11: 8]), .P( P8), .G( G8));
	  FourBits_CLA_adder FCa3(.A(A[15:12]), .B(B[15:12]), .Cin(C12), .S(Sum[15:12]), .P(P12), .G(G12));
     
endmodule




// 4-bits CLA adder
module FourBits_CLA_adder
(
	input		logic[3:0]	A,
	input		logic[3:0]	B,
	input		logic			Cin,
	output	logic[3:0]	S,
	output	logic			P,
	output	logic			G
);
	
	// Define some internal wires for carry out signals and generating/propagating signals
	logic P0, P1, P2, P3, G0, G1, G2, G3, C1, C2, C3;
	
	// Calculate the carry out values as well as generating/propagating values
	assign C1 = (Cin & P0) | G0;
	assign C2 = (Cin & P0 & P1) | (G0 & P1) | G1;
	assign C3 = (Cin & P0 & P1 & P2) | (G0 & P1 & P2) | (G1 & P2) | G2;
	
	assign P = P0 & P1 & P2 & P3;
	assign G = G3 | (G2 & P3) | (G1 & P3 & P2) | (G0 & P3 & P2 & P1);
	
	// Implement 4-bits CLA adder using 1-bit CLA adders
	CLA_adder Ca0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .P(P0), .G(G0));
	CLA_adder Ca1(.A(A[1]), .B(B[1]), .Cin( C1), .S(S[1]), .P(P1), .G(G1));
	CLA_adder Ca2(.A(A[2]), .B(B[2]), .Cin( C2), .S(S[2]), .P(P2), .G(G2));
	CLA_adder Ca3(.A(A[3]), .B(B[3]), .Cin( C3), .S(S[3]), .P(P3), .G(G3));

endmodule




// 1-bit CLA adder
module CLA_adder
(
	input		logic		A,
	input		logic		B,
	input		logic		Cin,
	output	logic		S,
	output	logic		P,
	output	logic		G
);

	assign G = A & B;
	assign P = A ^ B;
	assign S = A ^ B ^ Cin;

endmodule
	