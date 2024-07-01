module binary_to_7seg(

  input CLK, 
  input [3:0] binary_num,
  output o_S1_A, 
  output o_S1_B, 
  output o_S1_C, 
  output o_S1_D,
  output o_S1_E, 
  output o_S1_F, 
  output o_S1_G
  );
  
reg [6:0] hex_encoding = 7'h00;

always @(posedge CLK)begin
  case(binary_num)
    4'b0000 : hex_encoding <= 7'h7E;
    4'b0001 : hex_encoding <= 7'h30;
    4'b0010 : hex_encoding <= 7'h6D;
    4'b0011 : hex_encoding <= 7'h79;
    4'b0100 : hex_encoding <= 7'h33;
    4'b0101 : hex_encoding <= 7'h5B;
    4'b0110 : hex_encoding <= 7'h5F;
    4'b0111 : hex_encoding <= 7'h70;
    4'b1000 : hex_encoding <= 7'h7F;
    4'b1001 : hex_encoding <= 7'h7B;
    4'b1010 : hex_encoding <= 7'h77;
    4'b1011 : hex_encoding <= 7'h1F;
    4'b1100 : hex_encoding <= 7'h4E;
    4'b1101 : hex_encoding <= 7'h3D;
    4'b1110 : hex_encoding <= 7'h4F;
    4'b1111 : hex_encoding <= 7'h47;
    endcase
  end

assign o_S1_A = hex_encoding[6];
assign o_S1_B = hex_encoding[5];
assign o_S1_C = hex_encoding[4];
assign o_S1_D = hex_encoding[3];
assign o_S1_E = hex_encoding[2];
assign o_S1_F = hex_encoding[1];
assign o_S1_G = hex_encoding[0];

endmodule
    
