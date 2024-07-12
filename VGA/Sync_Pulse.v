module Sync_Pulse(
input CLK,
output H_Sync, V_Sync
);

// 800 Col by 525 Row
// 640 Col Active, 160 Col H-Sync
// 480 Row Active, 45 Row V-Sync

// 25Mhz Clock / (800 by 525) Area = 60Hz refresh rate (60 clock cycles per pixel per second)
// 25Mhz / 800 = 31250 Clock cycles per column
// 25Mhz / 525 = 47619.0476 Clock cycles per row

// H-Sync = High for 25000 Clock cycles
// V-Sync = High for 43537.4149 Clock cycles <-- UPDATE

reg [9:0] r_CountCol = 0;
reg [9:0] r_CountRow = 0;
reg r_H_Sync = 1'b1;
reg r_V_Sync = 1'b1;

always @(posedge CLK)
begin
   if (r_CountCol < 640)// maybe this should be 38400
    r_H_Sync <= 1'b1;
  else if (r_CountCol < 800)// maybe this should be 48000
    r_H_Sync <= 1'b0;
  else begin
    r_CountCol <= 0;
    r_H_Sync <= 1'b1;
  end
  r_CountCol <= r_CountCol + 1;
  
  if (r_CountRow < 480)// maybe this should be 28800
    r_V_Sync <= 1'b1;
  else if (r_CountRow < 525)// maybe this should be 31500
    r_V_Sync <= 1'b0;
  else begin
    r_CountRow <= 0;
    r_V_Sync <= 1'b1;
  end
    
  r_CountRow <= r_CountRow + 1;
end

assign H_Sync = r_H_Sync;
assign V_Sync = r_V_Sync;

endmodule
