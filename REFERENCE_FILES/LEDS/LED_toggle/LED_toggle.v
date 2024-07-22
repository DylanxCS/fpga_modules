module LED_toggle(
  input	Switch,
  input CLK,
  output r_LED = 1'b0
);
 
reg r_SW = 1'b0;
wire w_SW;

debounce_switch Instance
  (.CLK(CLK),
   .Switch(Switch),
   .o_Switch(w_SW));

always @(posedge CLK) begin
	r_SW <= w_SW;
	if (w_SW == 1'b0 && r_SW == 1'b1) begin
		r_LED <= ~r_LED;
	end
end
endmodule
