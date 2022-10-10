/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

 
 
/*------------------------- Memory block for character graph -------------------------*/
 
module  RAM_Character
(
		input [15:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

	// mem has width of 3 bits and a total of 400 addresses
	// [<number of bits per address - 1> : 0] mem [0 : <the number of address - 1>]
	logic [3:0] mem [0:23374];

	initial
	begin
		$readmemh("sprite_bytes/character.txt", mem);
	end


	always_ff @ (posedge Clk) begin
		data_Out<= mem[read_address];
	end

endmodule



/*------------------------- Memory block for spell -------------------------*/

module  RAM_Spell
(
		input [16:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

	// mem has width of 3 bits and a total of 400 addresses
	// [<number of bits per address - 1> : 0] mem [0 : <the number of address - 1>]
	logic [3:0] mem [0:66047];

	initial
	begin
		$readmemh("sprite_bytes/spell.txt", mem);
	end


	always_ff @ (posedge Clk) begin
		data_Out<= mem[read_address];
	end

endmodule



/*------------------------- Memory block for color panel -------------------------*/

module  RAM_ColorPalette
(
		input [3:0] read_address,
		input Clk,
		output logic [23:0] data_Out
);

	// mem has width of 3 bits and a total of 400 addresses
	// [<number of bits per address - 1> : 0] mem [0 : <the number of address - 1>]
	logic [23:0] mem [0:15];

	initial
	begin
		$readmemh("sprite_bytes/color_palette.txt", mem);
	end


	always_ff @ (posedge Clk) begin
		data_Out<= mem[read_address];
	end

endmodule