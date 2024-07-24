//TODO: 
// add parameters
// change variable names
// improve Sync_Pulse and Sync_Porch logic like using '?:' in assign statements
// use case for Pattern Gen
// implement RX and TX, keyboard input, and display
// figure out VGA display and UART on windows
 
module top_VGA(
input CLK, RX,
output VGA_HS, VGA_VS, 
output VGA_R0, VGA_R1, VGA_R2,
output VGA_G0, VGA_G1, VGA_G2, 
output VGA_B0, VGA_B1, VGA_B2,
output TX,
output S1_A, S1_B, S1_C, S1_D, S1_E, S1_F, S1_G,
output S2_A, S2_B, S2_C, S2_D, S2_E, S2_F, S2_G
//output [7:0] RX_Byte
);
//A - 011 1101 -> 3D
//a - 100 0111 -> 47
wire w_HSync, w_VSync, w_HSynch_Porch, w_VSync_Porch, w_HSync_PG, w_VSync_PG;
wire [9:0] w_CountCol, w_CountRow;
wire [2:0] w_Red;
wire [2:0] w_Green;
wire [2:0] w_Blue;

wire w_S1_A, w_S1_B, w_S1_C, w_S1_D, w_S1_E, w_S1_F, w_S1_G, w_S2_A, w_S2_B, w_S2_C, w_S2_D, w_S2_E, w_S2_F, w_S2_G;

//UART
wire w_RX_DV;
wire [7:0] w_RX_Byte;
wire w_TX_Active, w_TX_Serial;

UART_TX #(.CLKS_PER_BIT(217)) UART_TX_Inst
 (.CLK(CLK),
  .i_TX_DV(w_RX_DV),
  .i_TX_Byte(w_RX_Byte), 
  .TX(w_TX_Serial),
  .o_TX_Active(w_TX_Active),
  .o_TX_Done());
  
assign TX = w_TX_Active ? w_TX_Serial : 1'b1;
//assign RX_Byte = w_RX_Byte;

UART_RX #(.CLKS_PER_BIT(217)) UART_RX_Inst(
.CLK(CLK),
.RX(RX),
.o_RX_DV(w_RX_DV),
.o_RX_Byte(w_RX_Byte));

Binary_To_Seven_Seg binary_to_7seg_Inst1(
.CLK(CLK),
.binary_num(w_RX_Byte[7:4]),
.o_S1_A(w_S1_A),
.o_S1_B(w_S1_B),
.o_S1_C(w_S1_C),
.o_S1_D(w_S1_D),
.o_S1_E(w_S1_E),
.o_S1_F(w_S1_F),
.o_S1_G(w_S1_G));

assign S1_A = ~w_S1_A;
assign S1_B = ~w_S1_B;
assign S1_C = ~w_S1_C;
assign S1_D = ~w_S1_D;
assign S1_E = ~w_S1_E;
assign S1_F = ~w_S1_F;
assign S1_G = ~w_S1_G;

Binary_To_Seven_Seg binary_to_7seg_Inst2(
.CLK(CLK),
.binary_num(w_RX_Byte[3:0]),
.o_S1_A(w_S2_A),
.o_S1_B(w_S2_B),
.o_S1_C(w_S2_C),
.o_S1_D(w_S2_D),
.o_S1_E(w_S2_E),
.o_S1_F(w_S2_F),
.o_S1_G(w_S2_G));

assign S2_A = ~w_S2_A;
assign S2_B = ~w_S2_B;
assign S2_C = ~w_S2_C;
assign S2_D = ~w_S2_D;
assign S2_E = ~w_S2_E;
assign S2_F = ~w_S2_F;
assign S2_G = ~w_S2_G;


Sync_Pulse PulseInst
 (.CLK(CLK),
  .o_HSync(w_HSync),
  .o_VSync(w_VSync),
  .o_CountCol(w_CountCol),
  .o_CountRow(w_CountRow)
  );

Sync_Porch PorchInst
 (.CLK(CLK),
  .i_HSync(w_HSync),
  .i_VSync(w_VSync),
  .i_CountCol(w_CountCol),
  .i_CountRow(w_CountRow),
  .o_H_Sync(w_HSync_Porch),
  .o_V_Sync(w_VSync_Porch)
  );

Pattern_Generator Pattern_GenInst
 (.CLK(CLK),
  .i_Byte(w_RX_Byte),
  .i_HSync(w_HSync_Porch),
  .i_VSync(w_VSync_Porch),
  .o_HSync_PG(w_HSync_PG),
  .o_VSync_PG(w_VSync_PG),
  .Red(w_Red), 
  .Green(w_Green),
  .Blue(w_Blue)
  );

assign VGA_HS = w_HSync_PG;
assign VGA_VS = w_VSync_PG;

assign VGA_R0 = w_Red[0];
assign VGA_R1 = w_Red[1];
assign VGA_R2 = w_Red[2];

assign VGA_G0 = w_Green[0];
assign VGA_G1 = w_Green[1];
assign VGA_G2 = w_Green[2];

assign VGA_B0 = w_Blue[0];
assign VGA_B1 = w_Blue[1];
assign VGA_B2 = w_Blue[2];

endmodule

//iverilog -o simulation_tb Sync_Pulse.v Sync_Porch.v Pattern_Generator.v Binary_To_Seven_Seg.v UART_TX.v UART_RX.v top_VGA.v VGA_tb.v

