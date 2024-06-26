module and_gate(

  input	SW1, input SW2,
  input	SW3, input SW4,
  input CLK,
  
  output LED1, output LED2, 
  output LED3, output LED4
);
 
reg r_SW1 = 1'b0;
reg r_LED1 = 1'b0;

always @(posedge CLK) begin
	r_SW1 <= SW1;
	if (SW1 == 1'b0 && r_SW1 == 1'b1) begin
		r_LED1 <= ~r_LED1;
	end
end
assign LED1 = r_LED1;
endmodule
