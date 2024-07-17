module Pattern_Generator(
input CLK,
input [7:0] i_Keystroke,
//input i_H_Sync,
//input i_V_Sync,
output [7:0] Red,
output [7:0] Green,
output [7:0] Blue
);

reg [3:0] r_Keystroke;
reg [7:0] r_Red = 0;
reg [7:0] r_Green = 0;
reg [7:0] r_Blue = 0;

wire [9:0] w_CountCol;
wire [9:0] w_CountRow;

Sync_Pulse instance(
.CLK(CLK),
.H_Sync(),
.V_Sync(),
.CountCol(w_CountCol),
.CountRow(w_CountRow)
);

always @(posedge CLK)
begin
  if (r_Keystroke == 4'h1) begin //!,1,A,Q,a,q
    r_Red <= (w_CountCol < 640 && w_CountRow < 480) ? 3'b111 : 0;
    r_Green <= 0;
    r_Blue <= 0; end
  else if (r_Keystroke == 4'h2) begin //",2,B,R,b,r
    r_Red <= 0;
    r_Green <= (w_CountCol < 640 && w_CountRow < 480) ? 3'b111 : 0;
    r_Blue <= 0; end
  else if (r_Keystroke == 4'h3) begin //#,3...
    r_Red <= 0;
    r_Green <= 0;
    r_Blue <= (w_CountCol < 640 && w_CountRow < 480) ? 3'b111 : 0; end
  else begin //anything else makes screen Black
    r_Red <= 0; 
    r_Green <= 0;
    r_Blue <= 0; end
end

assign r_Keystroke = i_Keystroke;

assign Red = r_Red;
assign Green = r_Green;
assign Blue = r_Blue;
