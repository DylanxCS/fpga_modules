module Seven_Seg_Counter(

  input	CLK,
  input SW1,
  output S1_A, 
  output S1_B, 
  output S1_C, 
  output S1_D,
  output S1_E, 
  output S1_F, 
  output S1_G, 
  output LED1
);
 
wire w_SW1;
reg r_SW1 = 1'b0;
reg [3:0] r_Count1 = 4'b0000;

wire w_S1_A;
wire w_S1_B;
wire w_S1_C;
wire w_S1_D;
wire w_S1_E;
wire w_S1_F;
wire w_S1_G;


debounce_switch Instance(
   .CLK(CLK),
   .Switch(SW1),
   .o_Switch(w_SW1));

always @(posedge CLK) begin
	r_SW1 <= w_SW1;
	if (w_SW1 == 1'b0 && r_SW1 == 1'b1) begin
		r_LED1 <= ~r_LED1;
		if(r_Count1 == 9)
			r_Count1 <= 0;
		else
			r_Count1 <= r_Count1 + 1;
	end
end

Binary_To_Seven_Seg Instance2(
   .CLK(CLK),
   .binary_num(r_Count1),
   .o_S1_A(w_S1_A),
   .o_S1_B(w_S1_B),
   .o_S1_C(w_S1_C),
   .o_S1_D(w_S1_D),
   .o_S1_E(w_S1_E),
   .o_S1_F(w_S1_F),
   .o_S1_G(w_S1_G));

assign S1_A = ~w_S1_A;
assign S1_B = ~w_S1_B;
assign S1_C = ~w_S1_C;
assign S1_D = ~w_S1_D;
assign S1_E = ~w_S1_E;
assign S1_F = ~w_S1_F;
assign S1_G = ~w_S1_G;
assign LED1 = r_LED1;
endmodule
