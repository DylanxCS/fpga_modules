module LED_toggle(

  input	SW1, input SW2,
  input	SW3, input SW4,
  input CLK,
  
  output LED1, output LED2, 
  output LED3, output LED4
);
 
reg r_SW1 = 1'b0;
reg r_LED1 = 1'b0;
wire w_SW1;

debounce_switch Instance
  (.CLK(CLK),
   .Switch(SW1),
   .o_Switch(w_SW1));

always @(posedge CLK) begin
	r_SW1 <= w_SW1;
	if (w_SW1 == 1'b0 && r_SW1 == 1'b1) begin
		r_LED1 <= ~r_LED1;
	end
end
assign LED1 = r_LED1;
endmodule
