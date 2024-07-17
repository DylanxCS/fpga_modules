//This module alters the Sync_pulse signal to include the front & back porch

//Whole area -> 800x525, Visible area -> 640x480
//Hsync -> front: 18, back: 50, pulse: 92
//Vsync -> front: 10, back: 33, pulse: 2


module Sync_Porch(
  input CLK,
  input i_H_Sync,
  input i_V_Sync,
  output o_H_Sync = 1'b1, 
  output o_V_Sync = 1'b1);
  
  reg r_H_Sync = 1'b1;
  reg [4:0] r_HCountBP = 0;
  reg [6:0] r_HCountPulse = 0;
  
  reg r_V_Sync = 1'b1;
  reg [4:0] r_VCountBP = 0;
  reg [6:0] r_VCountPulse = 0;
  
  always @(posedge CLK)
  begin
    if (i_H_Sync == 0 && r_HCountBP !== 17) //falling edge
      r_HCountBP <= r_HCountBP + 1;
    else
      r_H_Sync <= 0;
      
    if (r_HCountBP == 17 && r_HCountPulse !== 92)
      r_HCountPulse <= r_HCountPulse + 1;
    else
      r_H_Sync <= 1;
      
    if (i_H_Sync == 1) 
      begin
      r_HCountBP <= 0;
      r_HCountPulse <= 0; 
      end
  end
  
  
  always @(posedge CLK)
  begin
    if (i_V_Sync == 0 && r_VCountBP !== 9) //falling edge
      r_VCountBP <= r_VCountBP + 1;
    else
      r_V_Sync <= 0;
      
    if (r_VCountBP == 9 && r_VCountPulse !== 2)
      r_VCountPulse <= r_VCountPulse + 1;
    else
      r_V_Sync <= 1;
      
    if (i_V_Sync == 1) 
      begin
      r_VCountBP <= 0;
      r_VCountPulse <= 0; 
      end

    assign o_H_Sync = r_H_Sync;
    assign o_V_Sync = r_V_Sync;
  end
  
endmodule
