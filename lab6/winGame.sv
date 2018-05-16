module winGame(HEX0, LEDR, L, R, Clock, Reset);
	output logic [6:0] HEX0;
	input logic [9:0] LEDR;
	input logic L, R, Clock, Reset;
	
	enum { NAN, A, B } ps, ns;
	
	localparam NDS = 7'b1111111;
	localparam ONE = 7'b1111001;
	localparam TWO = 7'b0100100;
	
	always_comb begin
		case(ps) 
			NAN: if (LEDR[1] & R & ~L) begin
						ns = A;
						HEX0 = NDS;
					end
					else if (LEDR[9] & L & ~R) begin
						ns = B;
						HEX0 = NDS;
					end
					else begin
						ns = NAN;
						HEX0 = NDS;
					end
			A:		begin 
						ns = A;
						HEX0 = ONE;
					end
			B:		begin
						ns = B;
						HEX0 = TWO;
					end
		endcase
	end
	
	
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= NAN;
		else 
			ps <= ns;
	end
endmodule

module winGame_testbench();
	logic [9:0] LEDR;
	logic L, R, Clock, Reset;
	
	winGame dut (.LEDR, .L, .R, .Clock, .Reset);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	initial begin
		@(posedge Clock);
		Reset <= 1;			@(posedge Clock);
		Reset <= 0;			@(posedge Clock);
		LEDR[9] = 1;		@(posedge Clock);
		L = 1;				@(posedge Clock);
		@(posedge Clock);
		$stop();
	end
endmodule