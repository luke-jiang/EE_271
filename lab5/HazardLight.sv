module HazardLight(LEDR, SW, clk, reset);
	output logic [2:0] LEDR;
	input logic [1:0] SW;
	input logic clk, reset;

	enum { A, B, C, D } ps, ns;

	always_comb begin
		case(ps)
			A:	if (~SW[1] & ~SW[0])
					ns = D;
				else if (~SW[1] & SW[0])
					ns = C;
				else
					ns = B;
			B:	if (~SW[1])
					ns = A;
				else
					ns = C;
			C:	if (~SW[0])
					ns = A;
				else
					ns = B;
			D:	ns = A;
		endcase
	end

	assign LEDR[2] = ns[1];
	assign LEDR[1] = ~(ns[1] | ns[0]);
	assign LEDR[0] = ns[0];

	always_ff @(posedge clk) begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end

endmodule

module HazardLight_testbench();
	logic [1:0] SW;
	logic [2:0] LEDR;
	logic clk, reset;

	HazardLight dut (.LEDR, .SW, .clk, .reset);

	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		@(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		SW <= 2'b00; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW <= 2'b01; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW <= 2'b10; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW <= 2'b01; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW <= 2'b00; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW <= 2'b10; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW <= 2'b00; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW <= 2'b10; @(posedge clk);
		SW <= 2'b01; @(posedge clk);
		SW <= 2'b10; @(posedge clk);
		SW <= 2'b00; @(posedge clk);
		 $stop; // End the simulation.
	 end

endmodule
