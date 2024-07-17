//RUN TB: iverilog -o simulation_tb Sync_Pulse.v Sync_Pulse_tb.v
//	  vvp simulation_tb


`timescale 1ns/1ns
module Sync_Pulse_tb();
  
  reg r_Clock = 0;
  wire H_Sync, V_Sync, oHSync, oVSync;
  
  Sync_Pulse inst1(
    .CLK(r_Clock),
    .H_Sync(H_Sync),
    .V_Sync(V_Sync),
    .CountCol(),
    .CountRow());
    
  Sync_Porch inst2(
    .CLK(r_Clock),
    .i_H_Sync(H_Sync),
    .i_V_Sync(V_Sync),
    .o_H_Sync(oHSync),
    .o_V_Sync(oVSync));
  
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
