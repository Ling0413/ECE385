// Determine whehter VGA coordinate is within a spirit' displaying area.

module is_spirit (
	input  logic [9:0]	VGA_X, VGA_Y,				// X and Y coordinate of current displayed pixel in screen
	input  logic [9:0]  	Spirit_X, Spirit_Y,		// X and Y coordinate of left-up cornner of spirit in state (which is larger than screen)
	input  logic [7:0]  	Offset_X, Offset_Y,		// The size of rectangle spirit
	input  logic [9:0]  	LeftEdge,					// Left edge of screen in the state coordinate
	output logic [9:0]	dX,							// X coordinate of pixel w.r.t left-up corner of spirit
	output logic [9:0]	dY,							// Y coordinate of pixel w.r.t left-up corner of spirit
	output logic  		  	IsSpirite
);

	logic [9:0] Xmin, Xmax, Ymin, Ymax;
	
	always_comb begin
			Xmin = Spirit_X - LeftEdge;
			Xmax = Spirit_X - LeftEdge + {2'b00, Offset_X};
			Ymin = Spirit_Y;
			Ymax = Spirit_Y + {2'b00, Offset_Y};
			
			if ((VGA_X >= Xmin) && (VGA_X <= Xmax) && (VGA_Y >= Ymin) && (VGA_Y <= Ymax)) begin
					IsSpirite = 1;
					dX = VGA_X - Xmin;
					dY = VGA_Y - Ymin;
			end
			else begin
					IsSpirite = 0;
					dX = 10'b0;
					dY = 10'b0;
			end
	end 

endmodule 