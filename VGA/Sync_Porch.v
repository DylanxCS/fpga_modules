//This module alters the Sync_pulse signal to include the front & back porch

//Whole area -> 800x525, Visible area -> 640x480
//Hsync -> front: 18, back: 50, pulse: 92
//Vsync -> front: 10, back: 33, pulse: 2

//

module Sync_Porch(
  input CLK,
  input i_HSync,
  input i_VSync,
  input [9:0] i_CountCol,
  input [9:0] i_CountRow,
  output o_H_Sync, 
  output o_V_Sync);
  
  assign o_H_Sync = (i_CountCol < 640+18 || i_CountCol > 800-50-1) ? 1'b1 : i_HSync;
  assign o_V_Sync = (i_CountRow < 480+10 || i_CountRow > 525-33-1) ? 1'b1 : i_VSync;
  
endmodule
