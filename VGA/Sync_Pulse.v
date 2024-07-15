module Sync_Pulse(
input CLK,
output H_Sync, V_Sync
);

// 800 Col by 525 Row
// 640 Col Active, 160 Col H-Sync
// 480 Row Active, 45 Row V-Sync

// 25Mhz Clock / (800 by 525) Area = 60Hz refresh rate (60 clock cycles per pixel per second)

reg [9:0] r_CountCol = 0;
reg [9:0] r_CountRow = 0;
reg r_H_Sync = 1'b1;
reg r_V_Sync = 1'b1;

always @(posedge CLK)
begin
  if (r_CountCol == 799)
    begin
      r_CountCol <= 0;
      if (r_CountRow == 524)
        r_CountRow <= 0;
      else
        r_CountRow <= r_CountRow + 1;
      end
    else
      r_CountCol <= r_CountCol + 1;
end

assign H_Sync = (r_CountCol < 640) ? 1'b1 : 1'b0;
assign V_Sync = (r_CountRow < 480) ? 1'b1 : 1'b0;

endmodule
