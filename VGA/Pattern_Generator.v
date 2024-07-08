module Pattern_Generator(
input CLK,
input [7:0] Keystroke,
output [7:0] Red,
output [7:0] Green,
output [7:0] Blue
);

reg [7:0] r_Keystroke = Keystroke;
reg [7:0] r_Red = 0;
reg [7:0] r_Green = 0;
reg [7:0] r_Blue = 0;

always @(posedge CLK)
begin
  if (r_Keystroke == 8'b00110001) begin
    r_Red <= 8'b11111111;
    r_Green <= 8'b00000000;
    r_Blue <= 8'b00000000; end
  else if (r_Keystroke == 8'b00110010) begin
    r_Red <= 8'b00000000;
    r_Green <= 8'b11111111;
    r_Blue <= 8'b00000000; end
  else if (r_Keystroke == 8'b00110011) begin
    r_Red <= 8'b00000000;
    r_Green <= 8'b00000000;
    r_Blue <= 8'b11111111; end
  else begin
    r_Red <= 8'b00000000; 
    r_Green <= 8'b00000000;
    r_Blue <= 8'b00000000; end
end

assign Red = r_Red;
assign Green = r_Green;
assign Blue = r_Blue;
