module buttonDetect(out, KEY, Clock, Reset);
	output logic out;
	input logic KEY, Clock, Reset;

	logic press;

	always_ff @(posedge Clock) begin
		press <= KEY;
	end

	assign out = ~press & KEY;

endmodule

module buttonDetect_testbench();
	logic out, KEY, Clock, Reset;

	buttonDetect dut (.out, .KEY, .Clock, .Reset);

	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	initial begin
		@(posedge Clock);
		Reset <= 1;	KEY <= 0; @(posedge Clock);
		Reset <= 0; @(posedge Clock);
		KEY <= 1; @(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		KEY <= 0; @(posedge Clock);
		@(posedge Clock);
		$stop();
	end
endmodule
