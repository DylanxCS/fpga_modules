module Sync_Pulse(
input CLK,
output H_pulse, V_pulse
);

// 800 Col by 525 Row
// 640 Col Active, 160 Col H-Sync
// 480 Row Active, 45 Row V-Sync

// 25Mhz Clock / (800 by 525) Area = 60Hz refresh rate (60 clock cycles per pixel per second)
// 25Mhz / 800 = 31250 Clock cycles per column
// 25Mhz / 525 = 47619.0476 Clock cycles per row

// H-Sync = High for 25000 Clock cycles
// V-Sync = High for 43537.4149 Clock cycles 

reg [14:0] r_CountCol = 0;
reg [15:0] r_CountRow = 0;
reg r_H_pulse = 1'b1;
reg r_V_pulse = 1'b1;

always @(posedge CLK)
begin
   if (r_CountCol < 38400)// maybe this should be 540
    r_H_pulse <= 1'b1;
  else if (r_CountCol < 48000)// maybe this should be 800
    r_H_pulse <= 1'b0;
  else
    r_CountCol <= 0;
  
  r_CountCol <= r_CountCol + 1;
  
  if (r_CountRow < 28800)
    r_V_pulse <= 1'b1;
  else if (r_CountRow < 31500)
    r_V_pulse <= 1'b0;
  else
    r_CountRow <= 0;
    
  r_CountRow <= r_CountRow + 1;
end

assign H_pulse = r_H_pulse;
assign V_pulse = r_V_pulse;

endmodule