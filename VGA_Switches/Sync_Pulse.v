module Sync_Pulse( //IMPROVE: add parameters
input CLK,
output o_HSync, o_VSync,
output reg [9:0] o_CountCol = 0,
output reg [9:0] o_CountRow = 0
);

always @(posedge CLK)
  begin
  if (o_CountCol < 799) //target-1
    o_CountCol <= o_CountCol + 1;
  else 
    begin
    o_CountCol <= 0;
    if (o_CountRow < 524) 
      o_CountRow <= o_CountRow + 1; 
    else
      o_CountRow <= 0;
    end
end

assign o_HSync = (o_CountCol < 640) ? 1'b1 : 1'b0;
assign o_VSync = (o_CountRow < 480) ? 1'b1 : 1'b0;

endmodule

// 800 Col by 525 Row
// 640 Col Active
// 480 Row Active

// 25 Mhz Clock / (800 by 525) Area = 60 Hz refresh rate (60 clock cycles per pixel per second)
