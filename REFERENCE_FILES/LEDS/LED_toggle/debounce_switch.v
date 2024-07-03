module debounce_switch(
	input CLK,
	input Switch,
	output o_Switch);
	
parameter c_DEBOUNCE_LIMIT = 250000;// 10 ms at 25 MHz

reg r_State = 1'b0;
reg [17:0] r_Count = 0;

always @(posedge CLK) begin// COUNTER LOGIC
	if (Switch !== r_State && r_Count < c_DEBOUNCE_LIMIT)
		r_Count <= r_Count + 1;
	else if (r_Count == c_DEBOUNCE_LIMIT) begin
		r_Count <= 0;
		r_State <= Switch;end
	else
		r_Count <= 0;
	end

assign o_Switch = r_State;

endmodule
