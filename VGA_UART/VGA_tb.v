//RUN TB: iverilog -o simulation_tb Sync_Pulse.v Sync_Pulse_tb.v
//	  vvp simulation_tb


`timescale 1ns/1ns
module VGA_tb();
  
  reg r_Clock = 0;
  wire H_Sync, V_Sync, r0,r1,r2,g0,g1,g2,b0,b1,b2;
  reg r_RX_Serial = 1;
  wire [7:0] w_RX_Byte;
  
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer     ii;
    begin
      
      // Send Start Bit
      r_RX_Serial <= 1'b0;
      #(8600);
      #1000;
      
      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1)
        begin
          r_RX_Serial <= i_Data[ii];
          #(8600);
        end
      
      // Send Stop Bit
      r_RX_Serial <= 1'b1;
      #(8600);
     end
  endtask 
  
 top_VGA inst
  (.CLK(r_Clock),
   .RX(r_RX_Serial),
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
   .VGA_B2(b2),
   .TX(),
   .S1_A(), .S1_B(), .S1_C(), .S1_D(), .S1_E(), .S1_F(), .S1_G(),
.S2_A(), .S2_B(), .S2_C(), .S2_D(), .S2_E(), .S2_F(), .S2_G(),
.RX_Byte(w_RX_Byte)
   );
  
  always #(20)
    r_Clock <= ~r_Clock;
  
  initial
    begin
    @(posedge r_Clock);
      UART_WRITE_BYTE(4'h1);
     @(posedge r_Clock);
            
      // Check that the correct command was received
      if (w_RX_Byte == 4'h1)
        $display("Test Passed - Correct Byte Received");
      else
        $display("Test Failed - Incorrect Byte Received");
    end
    
initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    #120000
    $finish;
    end
  
endmodule
