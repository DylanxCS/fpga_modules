// Code testbench here
module Blink_LED_TB();
  
  reg r_Clock = 1'b0;
  
  always #1 r_Clock <= ~r_Clock;
  
  Blink_LED #(.COUNT_10HZ(5),
              .COUNT_5HZ(10),
              .COUNT_2HZ(25),
              .COUNT_1HZ(30)) UUT
  (.CLK(r_Clock),
   .LED1(),
   .LED2(),
   .LED3(),
   .LED4());
  
  initial
    begin
      $display("Starting Testbench...");
      #200;
      $finish();
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0);
    end
  
endmodule