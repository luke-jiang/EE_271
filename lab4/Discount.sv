module Discount(out, U, P, C);
	output logic out;
	input logic U, P, C;
	logic UC;
	
	and G1 (UC, U, C);
	or G2 (out, P, UC);
endmodule
