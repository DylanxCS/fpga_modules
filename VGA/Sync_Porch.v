//This module alters the Sync_pulse signal to include the front & back porch

//Whole area -> 800x525, Visible area -> 640x480
//Hsync -> front: 18, back: 50, pulse: 92
//Vsync -> front: 10, back: 33, pulse: 2


module Sync_Porch(
  input CLK,
  input i_H_Sync, i_V_Sync
  output o_H_Sync, o_V_Sync);
  
  reg r_H_Sync = 1'b1;
  reg r_V_Sync = 1'b1;
  reg r_Count = 0;
  
  always @(posedge CLK)
  begin
    if (i_H_Sync == 1'b0 && r_H_Sync = 1'b1)
    begin
      if (r_Count < 
      
