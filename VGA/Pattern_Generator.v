module Pattern_Generator(
input CLK,
input i_SW1, i_SW2, i_SW3, i_SW4,
input i_HSync,
input i_VSync,
output reg o_HSync_PG = 0, 
output reg o_VSync_PG = 0,
output reg [2:0] Red = 0,
output reg [2:0] Green = 0,
output reg [2:0] Blue = 0
);

always @(posedge CLK)
begin
  o_HSync_PG <= i_HSync;
  o_VSync_PG <= i_VSync;
  if (i_SW1) begin //!,1,A,Q,a,q
    Red <= (i_HSync && i_VSync) ? 3'b111 : 0;
    Green <= 0;
    Blue <= 0; end
  else if (i_SW2) begin //",2,B,R,b,r
    Red <= 0;
    Green <= (i_HSync && i_VSync) ? 3'b111 : 0;
    Blue <= 0; end
  else if (i_SW3) begin //#,3...
    Red <= 0;
    Green <= 0;
    Blue <= (i_HSync && i_VSync) ? 3'b111 : 0; end
  else if (i_SW4) begin //anything else makes screen Black
    Red <= 0; 
    Green <= 0;
    Blue <= 0; end
end 

endmodule
