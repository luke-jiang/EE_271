module Stolen(out, U, P, C, M);
	output logic out;
	input logic U, P, C, M;
	logic NU, NUC;
	
	not G1 (NU, U);
	and G2 (NUC, NU, C);
	nor G3 (out, NUC, P, M);
endmodule
