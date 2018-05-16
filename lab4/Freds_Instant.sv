module Freds_Instant(HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, SW);
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	input logic [2:0] SW; 
	logic [6:0] h5, h4, h3, h2, h1, h0;

	Freds freds (.hex5(h5), .hex4(h4), .hex3(h3), .hex2(h2), .hex1(h1), .hex0(h0), .upc(SW[2:0]));
	
	assign HEX5 = ~h5;
	assign HEX4 = ~h4;
	assign HEX3 = ~h3;
	assign HEX2 = ~h2;
	assign HEX1 = ~h1;
	assign HEX0 = ~h0;
	
endmodule
