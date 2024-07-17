module Sync_Pulse( //IMPROVE: add parameters
input CLK,
output reg H_Sync = 1'b1,
output reg V_Sync = 1'b1,
output reg [9:0] CountCol = 0,
output reg [9:0] CountRow = 0
);

// 800 Col by 525 Row
// 640 Col Active, 160 Col H-Sync
// 480 Row Active, 45 Row V-Sync

// 25Mhz Clock / (800 by 525) Area = 60Hz refresh rate (60 clock cycles per pixel per second)

reg [9:0] r_CountCol = 0;
reg [9:0] r_CountRow = 0;

always @(posedge CLK)
begin
  if (r_CountCol < 639) begin //target-1
    H_Sync <= 1'b1;
    r_CountCol <= r_CountCol + 1; end
  else if (r_CountCol < 799) begin
    H_Sync <= 1'b0;
    r_CountCol <= r_CountCol + 1; end
  else 
  begin
    r_CountCol <= 0;
    H_Sync <= 1'b1;
    
    if (r_CountRow < 479) begin
      V_Sync <= 1'b1;
      r_CountRow <= r_CountRow + 1; end
    else if (r_CountRow < 524) begin 
      V_Sync <= 1'b0;
      r_CountRow <= r_CountRow + 1; end
    else begin
      r_CountRow <= 0;
      V_Sync <= 1'b1; end
  end
  
  CountCol <= r_CountCol;
  CountRow <= r_CountRow;
end

//IMPROVE: logic above and assignment statements using ?:

endmodule
