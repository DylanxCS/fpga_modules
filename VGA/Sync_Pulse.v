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
   if (r_CountCol < 640) begin
    r_H_Sync <= 1'b1;
    r_CountCol <= r_CountCol + 1; end
  else if (r_CountCol < 800) begin
    r_H_Sync <= 1'b0;
    r_CountCol <= r_CountCol + 1; end
  else 
  begin
    if (r_CountRow < 2) begin
      r_V_Sync <= 1'b1;
      r_CountRow <= r_CountRow + 1; end
    else if (r_CountRow < 3) begin 
      r_V_Sync <= 1'b0;
      r_CountRow <= r_CountRow + 1; end
    else begin
      r_CountRow <= 0;
      r_V_Sync <= 1'b1;
    end
    r_CountCol <= 0;
    r_H_Sync <= 1'b1;
  end
end

assign H_Sync = r_H_Sync;
assign V_Sync = r_V_Sync;

endmodule
