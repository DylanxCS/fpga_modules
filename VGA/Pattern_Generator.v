module Pattern_Generator(
input CLK,
input i_SW1, i_SW2, i_SW3, i_SW4,
output reg [2:0] Red = 0,
output reg [2:0] Green = 0,
output reg [2:0] Blue = 0
);

wire [9:0] w_CountCol = 0;
wire [9:0] w_CountRow = 0;
reg [9:0] r_CountCol = 0;
reg [9:0] r_CountRow = 0;

Sync_Pulse Inst (
 .CLK(CLK),
 .H_Sync(),
 .V_Sync(),
 .CountCol(w_CountCol),
 .CountRow(w_CountRow)
 );

always @(posedge CLK)
begin
  r_CountCol <= w_CountCol;
  r_CountRow <= w_CountRow;
  if (i_SW1) begin //!,1,A,Q,a,q
    Red <= (w_CountCol < 640 && w_CountRow < 480) ? 3'b111 : 0;
    Green <= 0;
    Blue <= 0; end
  else if (i_SW2) begin //",2,B,R,b,r
    Red <= 0;
    Green <= (w_CountCol < 640 && w_CountRow < 480) ? 3'b111 : 0;
    Blue <= 0; end
  else if (i_SW3) begin //#,3...
    Red <= 0;
    Green <= 0;
    Blue <= (w_CountCol < 640 && w_CountRow < 480) ? 3'b111 : 0; end
  else if (i_SW4) begin //anything else makes screen Black
    Red <= 0; 
    Green <= 0;
    Blue <= 0; end
end

endmodule
