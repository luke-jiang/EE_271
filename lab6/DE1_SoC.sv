module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0] LEDR;
	 input logic [3:0] KEY;
	 input logic [9:0] SW;
	 input logic CLOCK_50;
	 

	 assign HEX1 = 7'b1111111;
	 assign HEX2 = 7'b1111111;
	 assign HEX3 = 7'b1111111;
	 assign HEX4 = 7'b1111111;
	 assign HEX5 = 7'b1111111;

	 logic Reset;
	 assign Reset = SW[9];
	 
	 assign Clock = CLOCK_50;
	 
	 logic L, R;
	 logic LK, RK;
	 
	 metastabilizer left_s  (.out(LK), .Clock, .Reset, .In(~KEY[3]));
	 metastabilizer right_s (.out(RK), .Clock, .Reset, .In(~KEY[0]));
	 
	 buttonDetect leftInput (.out(L), .KEY(LK), .Clock, .Reset);
	 buttonDetect rightInput (.out(R), .KEY(RK), .Clock, .Reset);
	 
	 LED_control LEDS (.LEDR, .L, .R, .Clock, .Reset);
	 
	 winGame Game (.HEX0, .LEDR, .L, .R, .Clock, .Reset);
	 
endmodule

module DE1_SoC_testbench();
	 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [9:0] LEDR;
	 logic [3:0] KEY;
	 logic [9:0] SW;
	 logic CLOCK_50;
	 
	 DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	 
	 parameter CLOCK_PERIOD = 100;
	 initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50;
	 end
	 
	 initial begin
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		SW[9] <= 1;@(posedge CLOCK_50);
		SW[9] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0;@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		KEY[3] <= 1;@(posedge CLOCK_50);
		KEY[3] <= 0;@(posedge CLOCK_50);
		SW[9] <= 1;@(posedge CLOCK_50);
		SW[9] <= 0;@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		KEY[3] <= 0; @(posedge CLOCK_50);
		
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1;@(posedge CLOCK_50);
		KEY[0] <= 0;@(posedge CLOCK_50);
		SW[9] <= 1;@(posedge CLOCK_50);
		SW[9] <= 0;@(posedge CLOCK_50);
		KEY[0] <= 1; KEY[3] <= 1; @(posedge CLOCK_50);
		KEY[0] <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
		$stop; // End the simulation.
	end
endmodule
		
		

