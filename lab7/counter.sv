module counter(out, HEX, match, Clock, Reset);
	output logic out;
	input logic match, Clock, Reset;
	output logic [6:0] HEX;
	
	logic [2:0] Lcount, Rcount;
	assign Lcount = 3'b000;
	assign Rcount = 3'b000;
	
	enum { s0, s1, s2, s3, s4, s5, s6, s7 } ps, ns;
	
	
	always_comb begin
		case(ps)
			s0:		if (match)		ns = s1;
						else				ns = s0;
			s1:		if (match)		ns = s2;
						else				ns = s1;
		   s2:		if (match)		ns = s3;
						else				ns = s2;
			s3:		if (match)		ns = s4;
						else				ns = s3;
			s4:		if (match)		ns = s5;
						else				ns = s4;
			s5:		if (match)		ns = s6;
						else				ns = s5;
			s6:		if (match)		ns = s7; // ns = s0;
						else				ns = s6;
			s7:							ns = s7;
		endcase
	end
	
	assign out = (ps == s7);
	
	seg7 display (.bcd(ps[2:0]), .leds(HEX));
	
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= s0;
		else 
			ps <= ns;
	end

endmodule

module counter_testbench();
	logic out;
	logic match, Clock, Reset;
	logic [6:0] HEX;
	
	counter dut(.out, .HEX, .match, .Clock, .Reset);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	initial begin
		Reset <= 1;				@(posedge Clock);
		Reset <= 0;				@(posedge Clock);
		match <= 1;				@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		$stop();
	end
endmodule





	
	
			