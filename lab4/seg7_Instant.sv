module seg7_Instant(SW, HEX1, HEX0);
	output logic [6:0] HEX1, HEX0;
	input logic [7:0] SW;
	logic [6:0] h0, h1;
	
	seg7 G1 (.bcd(SW[3:0]), .leds(h0));
	seg7 G2 (.bcd(SW[7:4]), .leds(h1));
	
	assign HEX0 = ~h0;
	assign HEX1 = ~h1;
	
endmodule
