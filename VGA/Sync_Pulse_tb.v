//RUN TB: iverilog -o simulation_tb Sync_Pulse.v Sync_Pulse_tb.v
//	  vvp simulation_tb


`timescale 1ns/10ps
module Sync_Pulse_tb();
  
  reg r_Clock = 0;
  wire H_Sync, V_Sync;
  
  Sync_Pulse inst(
    .CLK(r_Clock),
    .H_Sync(H_Sync),
    .V_Sync(V_Sync));
  
  always #(20)
    r_Clock <= ~r_Clock;
  
  reg h_sync_triggered = 0;
  reg v_sync_triggered = 0;

  always @(posedge r_Clock)       begin
    if (H_Sync == 1'b0 && !h_sync_triggered) begin
      h_sync_triggered <= 1'b1;
      $display("H_sync went to 1'b0 at time %0t", $time);
    end

    if (V_Sync == 1'b0 && !v_sync_triggered) begin
      v_sync_triggered <= 1'b1;
      $display("V_sync went to 1'b0 at time %0t", $time);
    end

    // Stop simulation when both H_sync and V_sync have triggered
    //if (h_sync_triggered && v_sync_triggered)
      //$finish;
  end
  
  initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars(0, inst);
    
    #2200000
    $finish;
  end
  
endmodule
