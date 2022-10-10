//------------------------------------------------------------------------------
// Company:        UIUC ECE Dept.
// Engineer:       Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 6 Given Code - SLC-3 
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 10-19-2017 
//    spring 2018 Distribution
//
//------------------------------------------------------------------------------
module slc3(
    input logic [15:0] S,
    input logic Clk, Reset, Run, Continue,
    output logic [11:0] LED,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
    output logic CE, UB, LB, OE, WE,
    output logic [19:0] ADDR,
    inout wire [15:0] Data //tristate buffers need to be of type wire
);

// Declaration of push button active high signals
logic Reset_ah, Continue_ah, Run_ah;

// (addition) Wires that connect to synchronizer 
logic Reset_S, Continue_S, Run_S;
logic OE_S, WE_S;

// (modified)
assign Reset_S = ~Reset;
assign Continue_S = ~Continue;
assign Run_S = ~Run;

// (addition) Adde synchronizer to stabilize the input
Register #(1) synchro_Key1(.Clk, .Load(1'b1), .Reset(1'b0), .Din(Reset_S   ), .Dout(Reset_ah	  ));
Register #(1) synchro_Key2(.Clk, .Load(1'b1), .Reset(1'b0), .Din(Continue_S), .Dout(Continue_ah));
Register #(1) synchro_Key3(.Clk, .Load(1'b1), .Reset(1'b0), .Din(Run_S     ), .Dout(Run_ah	  ));


// (addition) Adde synchronizer to stabilize the SRAM control signal
Register #(1) synchro_M1(.Clk, .Load(1'b1), .Reset(1'b0), .Din(OE_S), .Dout(OE));
Register #(1) synchro_M2(.Clk, .Load(1'b1), .Reset(1'b0), .Din(WE_S), .Dout(WE));

// Internal connections
logic BEN;
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX;
logic MIO_EN;

logic [15:0] MDR_In, MDR_In1;
logic [15:0] MAR, MDR, IR, PC;
logic [15:0] Data_from_SRAM, Data_to_SRAM;

logic [11:0] ledVecot12;

// Extra internal connnections for other parts
logic[15:0] 	bus_out;
logic[15:0]		SR1, SR2;
logic[15:0]		ALU_out;
logic[15:0]		AC_out;

// Signals being displayed on hex display
logic [3:0][3:0] hex_4;

//// For week 1, hexdrivers will display IR. Comment out these in week 2.
//HexDriver hex_driver3 (IR[15:12], HEX3);
//HexDriver hex_driver2 (IR[11:8], HEX2);
//HexDriver hex_driver1 (IR[7:4], HEX1);
//HexDriver hex_driver0 (IR[3:0], HEX0);

 // For week 2, hexdrivers will be mounted to Mem2IO
 HexDriver hex_driver3 (hex_4[3][3:0], HEX3);
 HexDriver hex_driver2 (hex_4[2][3:0], HEX2);
 HexDriver hex_driver1 (hex_4[1][3:0], HEX1);
 HexDriver hex_driver0 (hex_4[0][3:0], HEX0);

// The other hex display will show PC for both weeks.
HexDriver hex_driver7 (PC[15:12], HEX7);
HexDriver hex_driver6 (PC[11:8], HEX6);
HexDriver hex_driver5 (PC[7:4], HEX5);
HexDriver hex_driver4 (PC[3:0], HEX4);

// Connect MAR to ADDR, which is also connected as an input into MEM2IO.
// MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
// input into MDR)
assign ADDR = { 4'b00, MAR }; //Note, our external SRAM chip is 1Mx16, but address space is only 64Kx16
assign MIO_EN = ~OE;


// Our SRAM and I/O controller
Mem2IO memory_subsystem(
    .*, .Reset(Reset_ah), .ADDR(ADDR), .Switches(S),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]),
    .Data_from_CPU(MDR), .Data_to_CPU(MDR_In1),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// The tri-state buffer serves as the interface between Mem2IO and SRAM
tristate #(.N(16)) tr0(
    .Clk(Clk), .tristate_output_enable(~WE), .Data_write(Data_to_SRAM), .Data_read(Data_from_SRAM), .Data(Data)
);

// State machine and control signals
ISDU state_controller(
    .*, .Reset(Reset_ah), .Run(Run_ah), .Continue(Continue_ah),
    .Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
    .Mem_CE(CE), .Mem_UB(UB), .Mem_LB(LB), .Mem_OE(OE_S), .Mem_WE(WE_S)
);



/*============================================= Our own code ================================================*/


// You need to make your own datapath module and connect everything to the datapath
// Be careful about whether Reset is active high or low
//datapath d0 (/* Please fill in the signals.... */);

// Register for LED displaying
Register #(12) LED_Reg(.Clk, .Load(LD_LED), .Reset(Reset_ah), .Din(IR[11:0]), .Dout(LED));


// Bus
Bus  Bus_inst(.*, .from_MARMUX(AC_out), .from_PC(PC), .from_MDR(MDR), .from_ALU(ALU_out), .bus_out);


// IR
Register #(16) IR_Reg(.Clk, .Load(LD_IR), .Reset(Reset_ah), .Din(bus_out), .Dout(IR));


// MAR, MDR and selection
Register #(16) MAR_Reg(.Clk, .Load(LD_MAR), .Reset(Reset_ah), .Din(bus_out), .Dout(MAR));
Register #(16) MDR_Reg(.Clk, .Load(LD_MDR), .Reset(Reset_ah), .Din(MDR_In), .Dout(MDR));

always_comb 
begin
		if (MIO_EN)
			MDR_In = MDR_In1;
		else
			MDR_In = bus_out;
end


// PC
PC	PC_inst(.LD_PC, .Reset(Reset_ah), .Clk, .PCMUX, .from_bus(bus_out), .from_AC(AC_out), .PC_out(PC));


// Register file
RegisterFile RF_inst(.Clk, .DRMUX, .SR1MUX, .LD_REG, .from_bus(bus_out), .from_IR(IR), .SR1_out(SR1), .SR2_out(SR2));


// nzp
NZP NZP_inst(.Clk, .Reset(Reset_ah), .LD_CC, .LD_BEN, .from_bus(bus_out), .from_IR(IR), .BEN);


// ALU
ALU ALU_inst(.SR2MUX, .ALUK, .IR, .SR2, .SR1, .ALU_out);


// Address calculator
AddressCalculator AC_inst(.ADDR1MUX, .ADDR2MUX, .IR, .from_PC(PC), .from_RF(SR1), .AC_out);


endmodule
		