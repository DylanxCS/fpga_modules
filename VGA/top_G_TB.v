module top_G_TB();

w_HSync, w_

Sync_Pulse PulseInst
 (.CLK(CLK),
  .o_HSync(w_HSync),
  .o_VSync(w_HSync),
  .o_CountCol(w_CountCol),
  .o_CountRow(w_CountRow)
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
