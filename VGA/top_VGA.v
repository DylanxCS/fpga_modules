//TODO: 
// add parameters
// change variable names
// improve Sync_Pulse and Sync_Porch logic like using '?:' in assign statements
// use case for Pattern Gen
// implement RX and TX, keyboard input, and display
// figure out VGA display and UART on windows
 
module top_VGA(
input CLK,
input SW1, SW2, SW3, SW4,
output VGA_HS, VGA_VS, 
output VGA_R0, VGA_R1, VGA_R2,
output VGA_G0, VGA_G1, VGA_G2, 
output VGA_B0, VGA_B1, VGA_B2
);

wire w_SW1, w_SW2, w_SW3, w_SW4;
wire w_HSync, w_VSync, w_HSynch_Porch, w_VSync_Porch, w_HSync_PG, w_VSync_PG;
wire [9:0] w_CountCol, w_CountRow;
wire [2:0] w_Red;
wire [2:0] w_Green;
wire [2:0] w_Blue;

Debounce_Switch debounceInst1
  (.CLK(CLK),
   .Switch(SW1),
   .o_Switch(w_SW1));
Debounce_Switch debounceInst2
  (.CLK(CLK),
   .Switch(SW2),
   .o_Switch(w_SW2));
Debounce_Switch debounceInst3
  (.CLK(CLK),
   .Switch(SW3),
   .o_Switch(w_SW3));
Debounce_Switch debounceInst4
  (.CLK(CLK),
   .Switch(SW4),
   .o_Switch(w_SW4));
   
Sync_Pulse PulseInst
 (.CLK(CLK),
  .o_HSync(w_HSync),
  .o_VSync(w_VSync),
  .o_CountCol(w_CountCol),
  .o_CountRow(w_CountRow)
  );

Sync_Porch PorchInst
 (.CLK(CLK),
  .i_H_Sync(w_HSync),
  .i_V_Sync(w_VSync),
  .o_H_Sync(w_HSync_Porch),
  .o_V_Sync(w_VSync_Porch)
  );

Pattern_Generator Pattern_GenInst
 (.CLK(CLK),
  .i_SW1(SW1), 
  .i_SW2(SW2), 
  .i_SW3(SW3), 
  .i_SW4(SW4),
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
