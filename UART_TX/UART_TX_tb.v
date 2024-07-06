/////////////////////////////////////////////////////////////////////
// File Downloaded from http://www.nandland.com
//////////////////////////////////////////////////////////////////////

// This testbench will exercise the UART RX.
// It sends out byte 0x37, and ensures the RX receives it correctly.
`timescale 1ns/10ps
`include "UART_RX.v"
module UART_TX_TB();

  // Testbench uses a 25 MHz clock (same as Go Board)
  // Want to interface to 115200 baud UART
  // 25000000 / 115200 = 217 Clocks Per Bit.
  parameter c_CLOCK_PERIOD_NS = 40;
  parameter c_CLKS_PER_BIT    = 217;
  parameter c_BIT_PERIOD      = 8600;
  
  reg r_Clock = 0;
  reg r_TX_DV = 0;
  wire w_TX_Active, w_UART_Line;
  wire w_TX_Serial;
  reg [7:0] r_TX_Byte = 0;
  wire [7:0] w_RX_Byte;
  
  UART_RX #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_RX_Inst
  (.CLK(r_Clock),
     .RX(w_UART_Line),
     .o_RX_DV(w_RX_DV),
     .o_RX_Byte(w_RX_Byte)
     );
  
  UART_TX #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_TX_Inst
  (.CLK(r_Clock),
     .i_TX_DV(r_TX_DV),
     .i_TX_Byte(r_TX_Byte),
     .TX(w_TX_Serial),
     .o_TX_Active(w_TX_Active),
     .o_TX_Done()
     );

//When transmitter is Active, we want to put the serialized data the transmitter is in control of, onto the UART line
  assign w_UART_Line = w_TX_Active ? w_TX_Serial : 1'b1;
  
  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
  
  // Main Testing:
  initial
    begin
      // Send a command to the UART (exercise Tx)
      @(posedge r_Clock);
      @(posedge r_Clock);
        r_TX_DV <= 1'b1;
        r_TX_Byte <= 8'h3A;
      @(posedge r_Clock);
        r_TX_DV <= 1'b0;
            
      // Check that the correct command was received
      @(posedge w_RX_DV);
      if (w_RX_Byte == 8'h3A)
        $display("Test Passed - Correct Byte Received");
      else
        $display("Test Failed - Incorrect Byte Received");
    $finish();
    end
  
  initial 
  begin
    // Required to dump signals to EPWave
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
endmodule