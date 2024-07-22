module SW_toggle(
  input	CLK,
  input i_SW,
  output reg o_SW = 1'b0
);
 
reg r_State = 1'b0;
wire w_SW;

Debounce_Switch Instance
  (.CLK(CLK),
   .Switch(i_SW),
   .o_Switch(w_SW));

always @(posedge CLK) begin
	r_State <= w_SW;
	if (w_SW == 1'b0 && r_State == 1'b1) begin
		o_SW <= ~o_SW;
	end
end
endmodule
