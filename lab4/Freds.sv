module Freds (hex5, hex4, hex3, hex2, hex1, hex0, upc);
	output logic [6:0] hex5, hex4, hex3, hex2, hex1, hex0;
	input logic [2:0] upc;
	
	always_comb begin
		case (upc)
			3'b000: begin
				hex5 = 7'b1111111;  // b
				hex4 = 7'b1111001;  // e
				hex3 = 7'b1011110;  // d
				hex2 = 7'b0000000;  
				hex1 = 7'b0000000;  
				hex0 = 7'b0000000;
			end
			3'b001: begin
				hex5 = 7'b1110111;  // a
				hex4 = 7'b1110011;  // p
				hex3 = 7'b1110011;  // p
				hex2 = 7'b0111000;  // l
				hex1 = 7'b1111001;  // e
				hex0 = 7'b0000000;
			end
			3'b011: begin
				hex5 = 7'b1111111;  // b
				hex4 = 7'b1111001;  // e
				hex3 = 7'b1111001;  // e
				hex2 = 7'b1110001;  // f
				hex1 = 7'b0000000;  
				hex0 = 7'b0000000;
			end
			3'b100: begin
				hex5 = 7'b1110001;  // f
				hex4 = 7'b1110101;  // r
				hex3 = 7'b0110000;  // i
				hex2 = 7'b1011110;  // d
				hex1 = 7'b1111101;  // g
				hex0 = 7'b1111001;  // e
			end
			3'b101: begin
				hex5 = 7'b0111001;  // c
				hex4 = 7'b1110111;  // a
				hex3 = 7'b1110101;  // r
				hex2 = 7'b0000000;  
				hex1 = 7'b0000000;  
				hex0 = 7'b0000000;
			end
			3'b110: begin
				hex5 = 7'b1110001;  // f
				hex4 = 7'b0110000;  // i
				hex3 = 7'b1101101;  // s
				hex2 = 7'b1110110;  // h
				hex1 = 7'b0000000;  
				hex0 = 7'b0000000;
			end
			default: begin
				hex5 = 7'bX;  
				hex4 = 7'bX;  
				hex3 = 7'bX;  
				hex2 = 7'bX;  
				hex1 = 7'bX;  
				hex0 = 7'bX;
			end
		endcase
	end
endmodule

module Freds_testbench();
	logic [2:0] upc;
	logic [6:0] hex5, hex4, hex3, hex2, hex1, hex0;
	
	Freds dut (.hex5, .hex4, .hex3, .hex2, .hex1, .hex0, .upc);
	
	integer i;
	initial begin
		for (i = 0; i < 7; i++) begin
			upc = i;
			#10;
		end
	end
endmodule