//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
				 input        [17:0] SW,
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
				 // SRAM I/O
				 inout wire   [15:0] Data,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
				 output logic [8:0]	LEDG
                    );
	 
	 /*---------------------------- Variables declaration ----------------------------*/
    logic Reset_h, Clk;
    logic [7:0] keycode, useless;
	 
	 // Additional variables defined for three modules
	 logic [9:0] DrawX, DrawY;
	 logic is_ball;
	 
	 // Interface export data
	 logic [63:0] EXPORT_DATA;
	 logic [63:0] IMPORT_DATA;

	 // On-chip Memory I/O
	 logic [3:0] color_character, color_boss, color_spell;
	 logic [3:0] color_index;
	 
	 // Color palette
	 logic [23:0] RGB;
	 
	 // Contact judgment
	 logic contact_cs;	// Character and spell
	 logic contact_cb;	// Character and boss
	 logic is_CS, is_CB;
	 
	 // Clock signal
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
	 
	 
	 /*---------------------------- Module initialization ----------------------------*/
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     lab8_soc nios_system(
                             .clk_clk(Clk),
									  .gamecontrol_export_new_signal(EXPORT_DATA),
									  .gamecontrol_export_new_signal_1(IMPORT_DATA),
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(useless),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );
    

    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    VGA_controller vga_controller_instance(.Clk, 
														 .Reset(Reset_h), 
														 .VGA_HS, 
														 .VGA_VS, 
														 .VGA_CLK, 
														 .VGA_BLANK_N, 
														 .VGA_SYNC_N,
														 .DrawX,
														 .DrawY
	 );
	 
    
	 
	 /*------------------------------- On-chip memory I/O -------------------------------*/
	 
	 // Character
	 RAM_Character Memory_character(.read_address(EXPORT_DATA[15:0]), .Clk(Clk), .data_Out(color_character));
	 
	 // Boss
	 RAM_Boss Memory_boss(.read_address(EXPORT_DATA[34:16]), .Clk(Clk), .data_Out(color_boss));
	 
	 // Spell
	 RAM_Spell Memory_spell(.read_address(EXPORT_DATA[51:35]), .Clk(Clk), .data_Out(color_spell));

	 /*------------------------------- Color palette -------------------------------*/
	 
	 // Determine which color to display
	 always_comb begin
	 
			// Default
			contact_cs = 1'b0;	// Character and spell
			contact_cb = 1'b0;	// Character and boss
			
			// Spell has highest priority
			if ((EXPORT_DATA[63] == 1) && (color_spell != 4'b0)) begin
					color_index = color_spell;
					// contact
					if (color_character != 4'b0) 
							contact_cs = 1'b1;
			end
			else if (DrawY >= 400) begin
					color_index = 5'd2;		// Display the ground color
			end
			else if ((EXPORT_DATA[61] == 1) && (color_character != 4'b0)) begin
					color_index = color_character;
					if (color_boss != 4'b0)
							contact_cb = 1'b1;
			end
			else if ((EXPORT_DATA[62] == 1) && (color_boss != 4'b0)) begin
					if (EXPORT_DATA[60] == 1)
							color_index = 4'b0001;
					else
							color_index = color_boss;
			end
			else
					color_index = 5'b0;		// If no spirit to be displayed, display the background color
	 end
	 

	 RAM_ColorPalette ColorPalette(.read_address(color_index), .Clk(Clk), .data_Out(RGB));
	 
	 assign VGA_R = RGB[23:16];
	 assign VGA_G = RGB[15:8];
	 assign VGA_B = RGB[7:0];
	 
	 /*------------------------------- Contect detection ------------------------------*/
	 
	 Contact cs(.Clk(Clk), .Reset(Reset_h), .contact_singal(contact_cs), .VGA_VS, .to_NiosII(is_CS));
	 Contact cb(.Clk(Clk), .Reset(Reset_h), .contact_singal(contact_cb), .VGA_VS, .to_NiosII(is_CB));
	 
	 
	 /*-------------------- Assign import/export pins of interface --------------------*/
	 
	 // Import
	 assign IMPORT_DATA[ 9: 0] = DrawX;
	 assign IMPORT_DATA[19:10] = DrawY;
	 assign IMPORT_DATA[20] = ~VGA_VS;
	 assign IMPORT_DATA[21] = is_CS;
	 assign IMPORT_DATA[22] = is_CB;
	 assign IMPORT_DATA[23] = Reset_h;
	 assign IMPORT_DATA[24] = SW[0];
	 
	 // Export
	 assign LEDG = EXPORT_DATA[59:52];


	 /*--------------------------------- Test display -------------------------------*/
//    HexDriver hex_inst_0 (EXPORT_DATA[ 3: 0], HEX0);
//    HexDriver hex_inst_1 (EXPORT_DATA[ 7: 4], HEX1);
//	 HexDriver hex_inst_2 (EXPORT_DATA[11: 8], HEX2);
//	 HexDriver hex_inst_3 (EXPORT_DATA[15:12], HEX3);
//		
//	 HexDriver hex_inst_4 (EXPORT_DATA[51:48], HEX4);
//	 HexDriver hex_inst_5 (EXPORT_DATA[55:52], HEX5);
//	 HexDriver hex_inst_6 (EXPORT_DATA[59:56], HEX6);
//	 HexDriver hex_inst_7 (EXPORT_DATA[63:60], HEX7);
	 
	 HexDriver hex_inst_0 (EXPORT_DATA[19:16], HEX0);
    HexDriver hex_inst_1 (EXPORT_DATA[23:20], HEX1);
	 HexDriver hex_inst_2 (EXPORT_DATA[27:24], HEX2);
	 HexDriver hex_inst_3 (EXPORT_DATA[31:28], HEX3);
		
	 HexDriver hex_inst_4 (EXPORT_DATA[35:32], HEX4);
	 HexDriver hex_inst_5 (EXPORT_DATA[39:36], HEX5);
	 HexDriver hex_inst_6 (EXPORT_DATA[43:40], HEX6);
	 HexDriver hex_inst_7 (EXPORT_DATA[47:44], HEX7);
    

endmodule
