//https://wiki.emacinc.com/wiki/Getting_Started_With_Minicom
//right side usb is serial port ttyUSB1
// minicom instructions:
// UART RX is configured under minicom port created titled ttyS12
// sudo minicom -s       or ttyS12 to configure existing instance
// configure serial port settings in minicom to be 115200 8N1
// 8 = 8 data bits, N = no parity, 1 = stop bit 1
// delete all modem and dialing stuff from A-H and K
// RUN MINICOM: minicom -D /dev/ttyUSB1
//okay so i think ttyS12 is just the configuration of USB1 i made?

module UART_RX_top(
input CLK,
input RX,
output S1_A, 
output S1_B, 
output S1_C, 
output S1_D,
output S1_E, 
output S1_F, 
output S1_G,
output S2_A, 
output S2_B, 
output S2_C, 
output S2_D,
output S2_E, 
output S2_F, 
output S2_G);

wire w_RX_DV;
reg [7:0] w_RX_Byte;

//wire w_RX;
wire w_S1_A;
wire w_S1_B;
wire w_S1_C;
wire w_S1_D;
wire w_S1_E;
wire w_S1_F;
wire w_S1_G;
wire w_S2_A;
wire w_S2_B;
wire w_S2_C;
wire w_S2_D;
wire w_S2_E;
wire w_S2_F;
wire w_S2_G;

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
endmodule
