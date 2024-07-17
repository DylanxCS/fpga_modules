//TODO: add parameters, change variable names, improve Sync_Pulse and Sync_Porch logic like using '?:' in assign statements, use case for Pattern Gen, implement RX and TX, keyboard input, and display.

module top_VGA(
input CLK,
input SW1, SW2, SW3, SW4,
output VGA_HS, VGA_VS, 
output VGA_R0, VGA_R1, VGA_R2,
output VGA_G0, VGA_G1, VGA_G2, 
output VGA_B0, VGA_B1, VGA_B2
);

wire w_SW1, w_SW2, w_SW3, w_SW3;
wire w_H_Sync, w_V_Sync;
wire w_CountCol, w_CountRow;

debounce_switch debounceInst1
  (.CLK(CLK),
   .Switch(SW1),
   .o_Switch(w_SW1));
debounce_switch debounceInst2
  (.CLK(CLK),
   .Switch(SW2),
   .o_Switch(w_SW2));
debounce_switch debounceInst3
  (.CLK(CLK),
   .Switch(SW3),
   .o_Switch(w_SW3));
debounce_switch debounceInst4
  (.CLK(CLK),
   .Switch(SW4),
   .o_Switch(w_SW4));
   
Sync_Pulse PulseInst
 (.CLK(CLK),
  .H_Sync(w_H_Sync),
  .V_Sync(w_H_Sync),
  .CountCol(w_CountCol),
  .CountRow(w_CountRow)
  );
  
Sync_Porch PorchInst
 (.CLK(CLK),
  .i_H_Sync(w_H_Sync),
  .i_V_Sync(w_V_Sync),
  .o_H_Sync(VGA_HS),
  .o_V_Sync(VGA_VS)
  );

Pattern_Generator Pattern_GenInst
 (.CLK(CLK),
  .i_H_Sync(w_H_Sync),
  .i_V_Sync(w_V_Sync),
  .i_SW1(SW1), 
  .i_SW2(SW2), 
  .i_SW3(SW3), 
  .i_SW4(SW4),
  .Red(), 
  .Green(),
  .Blue()
  );
