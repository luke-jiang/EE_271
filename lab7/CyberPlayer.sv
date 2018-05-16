module CyberPlayer(out, Q, SW, Clock, Reset);
	output logic out;
	input logic [9:0] Q;
	input logic [8:0] SW;
	input logic Clock, Reset;
	logic [9:0] SW_extended;
	
	assign SW_extended = {1'b0, SW};
	  // true then computer-press
	Comparator cmp (.out, .in1(SW_extended), .in2(Q), .Clock, .Reset);
		
endmodule


module CyberPlayer_testbench();
	logic out;
	logic [9:0] Q;
	logic [8:0] SW;
	logic Clock, Reset;	
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	initial begin
		Reset <= 1;			@(posedge Clock);
		Reset <= 0;			@(posedge Clock);
		
		Q = 9'b000000000;
		SW = 10'b0000000000;
		@(posedge Clock);
		Q = 9'b000000001;
		SW = 10'b0000000010;
		@(posedge Clock);
		Q = 9'b000000001;
		SW = 10'b0000000000;
		@(posedge Clock);
	end
	
endmodule
