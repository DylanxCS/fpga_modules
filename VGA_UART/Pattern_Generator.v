module Pattern_Generator(
input CLK,
input [7:0] i_Byte,
input i_HSync,
input i_VSync,
output reg o_HSync_PG = 1, 
output reg o_VSync_PG = 1,
output reg [2:0] Red = 0,
output reg [2:0] Green = 0,
output reg [2:0] Blue = 0
);

always @(posedge CLK)
begin
  o_HSync_PG <= i_HSync;
  o_VSync_PG <= i_VSync;
  if (i_Byte == 8'h31) begin //!,1,A,Q,a,q
    Red <= (i_HSync && i_VSync) ? 3'b111 : 0;
    Green <= 0;
    Blue <= 0; end
  else if (i_Byte == 8'h32) begin //",2,B,R,b,r
    Red <= 0;
    Green <= (i_HSync && i_VSync) ? 3'b111 : 0;
    Blue <= 0; end
  else if (i_Byte == 8'h33) begin //#,3...
    Red <= 0;
    Green <= 0;
    Blue <= (i_HSync && i_VSync) ? 3'b111 : 0; end
  else begin //anything else makes screen Black
    Red <= 0; 
    Green <= 0;
    Blue <= 0; end
end 

endmodule
