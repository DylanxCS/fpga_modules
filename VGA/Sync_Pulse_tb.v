//RUN TB: iverilog -o simulation_tb Sync_Pulse.v Sync_Pulse_tb.v
//	  vvp simulation_tb


`timescale 1ns/1ns
module Sync_Pulse_tb();
  
  reg r_Clock = 0;
  wire H_Sync, V_Sync, r0,r1,r2,g0,g1,g2,b0,b1,b2;
  
 top_VGA inst
  (.CLK(r_Clock),
   .SW1(1'b1),
   .SW2(1'b0),
   .SW3(1'b0),
   .SW4(1'b0),
   .VGA_HS(H_Sync),
   .VGA_VS(V_Sync),
   .VGA_R0(r0),
   .VGA_R1(r1),
   .VGA_R2(r2),
   .VGA_G0(g0),
   .VGA_G1(g1),
   .VGA_G2(g2),
   .VGA_B0(b0),
   .VGA_B1(b1),
   .VGA_B2(b2)
   );
  
  always #(20)
    r_Clock <= ~r_Clock;

  always @(posedge r_Clock)
    begin
    end
  
  initial
    begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    #500000
    $finish;
    end
  
endmodule
