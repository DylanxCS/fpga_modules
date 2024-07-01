//Verilog
module Blink_LED
  #(parameter COUNT_10HZ = 1250000,
    parameter COUNT_5HZ = 2500000,
    parameter COUNT_2HZ = 6250000,
    parameter COUNT_1HZ = 12500000)
  (input CLK,
   output reg LED1 = 1'b0,
   output reg LED2 = 1'b0,
   output reg LED3 = 1'b0,
   output reg LED4 = 1'b0);
  
reg [31:0] r_Count_10Hz = 0;
  reg [31:0] r_Count_5Hz = 0;
  reg [31:0] r_Count_2Hz = 0;
  reg [31:0] r_Count_1Hz = 0;

always @(posedge CLK)
begin
  if(r_Count_10Hz == COUNT_10HZ)
  begin
    LED1 <= ~LED1;
    r_Count_10Hz <=0;
  end
  else
    r_Count_10Hz <= r_Count_10Hz + 1;
end
  
always @(posedge CLK)
begin
  if(r_Count_5Hz == COUNT_5HZ)
  begin
    LED2 <= ~LED2;
    r_Count_5Hz <= 0;
  end
  else
    r_Count_5Hz <= r_Count_5Hz + 1;
end
  
always @(posedge CLK)
begin
  if(r_Count_2Hz == COUNT_2HZ)
  begin
    LED3 <= ~LED3;
    r_Count_2Hz <=0;
  end
  else
    r_Count_2Hz <= r_Count_2Hz + 1;
end
  
always @(posedge CLK)
begin
  if(r_Count_1Hz == COUNT_1HZ)
  begin
    LED4 <= ~LED4;
    r_Count_1Hz <=0;
  end
  else
    r_Count_1Hz <= r_Count_1Hz + 1;
end
  
endmodule