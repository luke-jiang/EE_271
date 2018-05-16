module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0] LEDR;
	 input logic [3:0] KEY;
	 input logic [9:0] SW;
	 input logic CLOCK_50;
	 

	 //assign HEX1 = 7'b1111111;
	 assign HEX2 = 7'b1111111;
	 assign HEX3 = 7'b1111111;
	 assign HEX4 = 7'b1111111;
	 assign HEX5 = 7'b1111111;

	 logic Reset;
	 assign Reset = SW[9];
	 
	 logic [31:0] clk;
	 parameter whichClock = 15;
	 clock_divider cdiv (.reset(~KEY[1]), .clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign Clock = clk[whichClock];
	 
	 logic L, R;
	 logic LK, RK;
	 logic cyber;
	 
	 metastabilizer left_s  (.out(LK), .Clock, .Reset, .In(cyber));
	 metastabilizer right_s (.out(RK), .Clock, .Reset, .In(~KEY[0]));
	 
	 buttonDetect leftInput (.out(L), .KEY(LK), .Clock, .Reset);
	 buttonDetect rightInput (.out(R), .KEY(RK), .Clock, .Reset);
	 
	 LED_control LEDS (.LEDR, .L, .R, .Clock, .Reset);
	 
	 logic [1:0] match;
	 logic Lwin, Rwin;
	 
	 logic win;
	 assign win = Lwin | Rwin;

	 winGame Game (.out(match), .LEDR, .L, .R, .Clock, .Reset);
	 counter Lcount (.out(Lwin), .HEX(HEX1), .match(match[1]), .Clock, .Reset);
	 counter Rcount (.out(Rwin), .HEX(HEX0), .match(match[0]), .Clock, .Reset);
	 
	 logic [9:0] Q;
	 
	 LFSR lfsr (.Q, .Clock, .Reset);
	 CyberPlayer cp (.out(cyber), .Q, .SW(SW[8:0]), .Clock, .Reset);
	 
endmodule

module clock_divider (reset, clock, divided_clocks);
	input logic clock, reset;
	output logic [31:0] divided_clocks;

	always_ff @(posedge clock) begin
		if (reset) begin
			divided_clocks <=0;
		end else begin
			divided_clocks <= divided_clocks + 1;
		end
	end

endmodule 

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	
	DE1_SoC dut(.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	
	initial begin
		// right player wins 7 times
		SW[9] <= 1; @(posedge CLOCK_50);
		SW[9] <= 0; @(posedge CLOCK_50);
		SW[8:0] <= 9'b000001000;@(posedge CLOCK_50);
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		KEY[1] <= 1;  @(posedge CLOCK_50);
		KEY[1] <= 0;  @(posedge CLOCK_50);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		
		
		// left player wins 1 time
		SW[9] <= 1; @(posedge CLOCK_50);
		SW[9] <= 0; @(posedge CLOCK_50);
		SW[8:0] <= 9'b100000000;@(posedge CLOCK_50);
		KEY[1] <= 1;  @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		$stop; // End the simulation.
	end
endmodule
	
	


