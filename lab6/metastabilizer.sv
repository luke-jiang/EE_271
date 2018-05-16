module metastabilizer(out, Clock, Reset, In);
	output logic out;
	input logic Clock, Reset, In;

	logic temp;
	always_ff @(posedge Clock) begin
		if (Reset)
			temp <= 0;
		else
			temp <= In;
	end

	always_ff @(posedge Clock) begin
		if (Reset)
			out <= 0;
		else
			out <= temp;
	end

endmodule

module metastablilzer_testbench();
	logic out, Clock, Reset, In;

	metastabilizer dut (.out, .Clock, .Reset, .In);

	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	initial begin
		Reset <= 1; @(posedge Clock);
		Reset <= 0; In <= 1; @(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		In <= 0; @(posedge Clock);
		In <= 1; @(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		In <= 0; @(posedge Clock);
		$stop();
	end

endmodule
