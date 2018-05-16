module LFSR(Q, Clock, Reset);
	output logic [9:0] Q;
	input logic Clock, Reset;
	logic xnor_out;
	// input: 10, 7
	xnor the_xnor (xnor_out, Q[0], Q[3]);
	always_ff @(posedge Clock) begin
		if (Reset)
			Q <= 10'b0000000000;
		else
			Q <= { xnor_out, Q[9:1] };
	end

endmodule

module LFSR_testbench();
	logic [9:0] Q;
	logic Clock, Reset;
	
	LFSR dut (.Q, .Clock, .Reset);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	initial begin
		Reset <= 1;		@(posedge Clock);
		Reset <= 0;		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		$stop();
	end
endmodule

