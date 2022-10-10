/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_gamecontrol_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [7:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [4:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [63:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [63:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Conduit signals
	input  logic [63:0] IMPORT_DATA,		// Import Conduit Signal from toplevel
	output logic [63:0] EXPORT_DATA		// Exported Conduit Signal to toplevel
);
	
	/*-------------------- Variables declaration --------------------*/
	
	// All registers
	logic [63:0] Regs_File [32];
	
	// VGA signal
	logic [9:0] VGA_X, VGA_Y;
	
	// Is spirit signal
	logic is_S0, is_S1, is_S2, is_S3, is_S4, is_S5, is_S6, is_S7, is_S8, is_S9, is_S10, is_S11, is_S12, is_S13, is_S14;
	logic [9:0]	dX0, dX1, dX2, dX3, dX4, dX5, dX6, dX7, dX8, dX9, dX10, dX11, dX12, dX13, dX14;
	logic [9:0]	dY0, dY1, dY2, dY3, dY4, dY5, dY6, dY7, dY8, dY9, dY10, dY11, dY12, dY13, dY14; 	
	
	// Address in SRAM
	logic [19:0] Address_character, Address_boss, Address_spell;
	logic is_spell;
	
	
	
	/*-------------------- Interface part --------------------*/
	
	// Register file
	always_ff @ (posedge CLK) begin
			if (RESET) begin
					for (int i = 0; i < 32; i++) begin
							Regs_File[i] <= 64'b0;
					end
			end
			else if (AVL_WRITE && AVL_CS) begin
					
					unique case (AVL_BYTE_EN)
							8'b11110000 : Regs_File[AVL_ADDR][63:32] <= AVL_WRITEDATA[63:32];
							8'b00001111 : Regs_File[AVL_ADDR][31: 0] <= AVL_WRITEDATA[31: 0];
							default Regs_File[AVL_ADDR] <= AVL_WRITEDATA;
					endcase
			end
			else begin
					for (int i = 0; i < 30; i++) begin
							Regs_File[i] <= Regs_File[i];
					end
					Regs_File[31] <= Regs_File[31];
					Regs_File[30][63:5] <= Regs_File[30][63:5];
					Regs_File[30][4] <= IMPORT_DATA[22];	// Character and boss
					Regs_File[30][3] <= IMPORT_DATA[21];	// Character and spell
					Regs_File[30][2] <= IMPORT_DATA[24];	// Golden finger
					Regs_File[30][1] <= IMPORT_DATA[20];	// Write-enable
					Regs_File[30][0] <= IMPORT_DATA[23];	// Reset
			end
	end
	
	
	// Perform read operation
	always_comb begin
			if (AVL_READ && AVL_CS) begin
					AVL_READDATA = Regs_File[AVL_ADDR];
			end
			else begin
					AVL_READDATA = 64'b0;
			end
	end
	
	
	
	/*-------------------- Address generation --------------------*/
	
	// Generate is spirit signal 
	is_spirit S0  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[ 1][19:10]), .Spirit_Y(Regs_File[ 1][9:0]), .Offset_X(Regs_File[ 1][35:28]), .Offset_Y(Regs_File[ 1][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX0), .dY( dY0), .IsSpirite( is_S0));
	is_spirit S1  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[ 3][19:10]), .Spirit_Y(Regs_File[ 3][9:0]), .Offset_X(Regs_File[ 3][35:28]), .Offset_Y(Regs_File[ 3][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX1), .dY( dY1), .IsSpirite( is_S1));
	is_spirit S2  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[ 5][19:10]), .Spirit_Y(Regs_File[ 5][9:0]), .Offset_X(Regs_File[ 5][35:28]), .Offset_Y(Regs_File[ 5][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX2), .dY( dY2), .IsSpirite( is_S2));
	is_spirit S3  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[ 7][19:10]), .Spirit_Y(Regs_File[ 7][9:0]), .Offset_X(Regs_File[ 7][35:28]), .Offset_Y(Regs_File[ 7][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX3), .dY( dY3), .IsSpirite( is_S3));
	is_spirit S4  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[ 9][19:10]), .Spirit_Y(Regs_File[ 9][9:0]), .Offset_X(Regs_File[ 9][35:28]), .Offset_Y(Regs_File[ 9][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX4), .dY( dY4), .IsSpirite( is_S4));
	is_spirit S5  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[11][19:10]), .Spirit_Y(Regs_File[11][9:0]), .Offset_X(Regs_File[11][35:28]), .Offset_Y(Regs_File[11][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX5), .dY( dY5), .IsSpirite( is_S5));
	is_spirit S6  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[13][19:10]), .Spirit_Y(Regs_File[13][9:0]), .Offset_X(Regs_File[13][35:28]), .Offset_Y(Regs_File[13][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX6), .dY( dY6), .IsSpirite( is_S6));
	is_spirit S7  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[15][19:10]), .Spirit_Y(Regs_File[15][9:0]), .Offset_X(Regs_File[15][35:28]), .Offset_Y(Regs_File[15][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX7), .dY( dY7), .IsSpirite( is_S7));
	is_spirit S8  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[17][19:10]), .Spirit_Y(Regs_File[17][9:0]), .Offset_X(Regs_File[17][35:28]), .Offset_Y(Regs_File[17][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX8), .dY( dY8), .IsSpirite( is_S8));
	is_spirit S9  (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[19][19:10]), .Spirit_Y(Regs_File[19][9:0]), .Offset_X(Regs_File[19][35:28]), .Offset_Y(Regs_File[19][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX( dX9), .dY( dY9), .IsSpirite( is_S9));
	is_spirit S10 (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[21][19:10]), .Spirit_Y(Regs_File[21][9:0]), .Offset_X(Regs_File[21][35:28]), .Offset_Y(Regs_File[21][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX(dX10), .dY(dY10), .IsSpirite(is_S10));
	is_spirit S11 (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[23][19:10]), .Spirit_Y(Regs_File[23][9:0]), .Offset_X(Regs_File[23][35:28]), .Offset_Y(Regs_File[23][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX(dX11), .dY(dY11), .IsSpirite(is_S11));
	is_spirit S12 (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[25][19:10]), .Spirit_Y(Regs_File[25][9:0]), .Offset_X(Regs_File[25][35:28]), .Offset_Y(Regs_File[25][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX(dX12), .dY(dY12), .IsSpirite(is_S12));
	is_spirit S13 (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[27][19:10]), .Spirit_Y(Regs_File[27][9:0]), .Offset_X(Regs_File[27][35:28]), .Offset_Y(Regs_File[27][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX(dX13), .dY(dY13), .IsSpirite(is_S13));
	is_spirit S14 (.VGA_X, .VGA_Y, .Spirit_X(Regs_File[29][19:10]), .Spirit_Y(Regs_File[29][9:0]), .Offset_X(Regs_File[29][35:28]), .Offset_Y(Regs_File[29][27:20]), .LeftEdge(Regs_File[31][9:0]), .dX(dX14), .dY(dY14), .IsSpirite(is_S14));
	
	// Generate address
	always_comb begin
		
		// Unique data bus for character
		if (is_S0) begin
				if (Regs_File[1][56]==0)
						Address_character = Regs_File[1][55:36] + dX0 + (Regs_File[31][19:10] * dY0);
				else
						Address_character = Regs_File[1][55:36] + {2'b00, Regs_File[1][35:28]} - dX0 + (Regs_File[31][19:10] * dY0) - 1;
		end
		else begin
			Address_character = 20'bZ;
		end
		
		// Unique data bus for boss
		if (is_S1) begin
				if (Regs_File[3][56]==0)
						Address_boss = Regs_File[3][55:36] + dX1 + (Regs_File[31][29:20] * dY1);
				else
						Address_boss = Regs_File[3][55:36] + {2'b00, Regs_File[3][35:28]} - dX1 + (Regs_File[31][29:20] * dY1) - 1;
		end
		else begin
			Address_boss = 20'bZ;
		end
		
		// Bus for spells
		if (is_S2) begin
			Address_spell = Regs_File[ 5][55:36] + dX2 + (Regs_File[31][39:30] * dY2);
			is_spell = 1'b1;
		end
		else if (is_S3) begin
			Address_spell = Regs_File[ 7][55:36] + dX3 + (Regs_File[31][39:30] * dY3);
			is_spell = 1'b1;
		end
		else if (is_S4) begin
			Address_spell = Regs_File[ 9][55:36] + dX4 + (Regs_File[31][39:30] * dY4);
			is_spell = 1'b1;
		end
		else if (is_S5) begin
			Address_spell = Regs_File[11][55:36] + dX5 + (Regs_File[31][39:30] * dY5);
			is_spell = 1'b1;
		end
		else if (is_S6) begin
			Address_spell = Regs_File[13][55:36] + dX6 + (Regs_File[31][39:30] * dY6);
			is_spell = 1'b1;
		end
		else if (is_S7) begin
			Address_spell = Regs_File[15][55:36] + dX7 + (Regs_File[31][39:30] * dY7);
			is_spell = 1'b1;
		end
		else if (is_S8) begin
			Address_spell = Regs_File[17][55:36] + dX8 + (Regs_File[31][39:30] * dY8);
			is_spell = 1'b1;
		end
		else if (is_S9) begin
			Address_spell = Regs_File[19][55:36] + dX9 + (Regs_File[31][39:30] * dY9);
			is_spell = 1'b1;
		end
		else if (is_S10) begin
			Address_spell = Regs_File[21][55:36] + dX10 + (Regs_File[31][39:30] * dY10);
			is_spell = 1'b1;
		end
		else if (is_S11) begin
			Address_spell = Regs_File[23][55:36] + dX11 + (Regs_File[31][39:30] * dY11);
			is_spell = 1'b1;
		end
		else if (is_S12) begin
			Address_spell = Regs_File[25][55:36] + dX12 + (Regs_File[31][39:30] * dY12);
			is_spell = 1'b1;
		end
		else if (is_S13) begin
			Address_spell = Regs_File[27][55:36] + dX13 + (Regs_File[31][39:30] * dY13);
			is_spell = 1'b1;
		end
		else if (is_S14) begin
			Address_spell = Regs_File[29][55:36] + dX14 + (Regs_File[31][39:30] * dY14);
			is_spell = 1'b1;
		end
		else begin
			Address_spell = 20'bZ;
			is_spell = 1'b0;
		end
		
	end
	
	/*-------------------- Import/export signal --------------------*/
	
	
	// Import
	assign VGA_X = IMPORT_DATA[9:0];
	assign VGA_Y = IMPORT_DATA[19:10];
	
	// Export
	assign EXPORT_DATA[15:0] = Address_character[15:0];	// 16 bits
	assign EXPORT_DATA[34:16] = Address_boss[18:0];			// 19 bits
	assign EXPORT_DATA[51:35] = Address_spell[16:0];	   // 17 bits
	assign EXPORT_DATA[59:52] = Regs_File[31][47:40]; 		// Health point
	assign EXPORT_DATA[60] = Regs_File[31][48];				// Boss hit signal
	assign EXPORT_DATA[61] = is_S0;
	assign EXPORT_DATA[62] = is_S1;
	assign EXPORT_DATA[63] = is_spell;

	
endmodule
