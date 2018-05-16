module LED_control(LEDR, L, R, Clock, Reset);
	output logic [9:0] LEDR;
	input  logic L, R, Clock, Reset;
	
	localparam state0 = 10'b0000000000;
	localparam state1 = 10'b0000000010;
	localparam state2 = 10'b0000000100;
	localparam state3 = 10'b0000001000;
	localparam state4 = 10'b0000010000;
	localparam state5 = 10'b0000100000;
	localparam state6 = 10'b0001000000;
	localparam state7 = 10'b0010000000;
	localparam state8 = 10'b0100000000;
	localparam state9 = 10'b1000000000;
	
	logic [9:0] ps, ns;
	
	always_comb begin
		case (ps)
			state0:									ns = state0;
			state1:			if (L & ~R)			ns = state2;
								else if (R & ~L)	ns = state0;
								else 					ns = state1;
			state2:			if (L & ~R) 		ns = state3;
								else if (R & ~L) 	ns = state1;
								else 					ns = state2;
			state3:			if (L & ~R) 		ns = state4;
								else if (R & ~L)	ns = state2;
								else					ns = state3;
			state4:			if (L & ~R) 		ns = state5;
								else if (R & ~L) 	ns = state3;
								else 					ns = state4;
			state5:			if (L & ~R) 		ns = state6;
								else if (R & ~L) 	ns = state4;
								else 					ns = state5;
			state6:			if (L & ~R) 		ns = state7;
								else if (R & ~L) 	ns = state5;
								else 					ns = state6;
			state7:			if (L & ~R) 		ns = state8;
								else if (R & ~L) 	ns = state6;
								else 					ns = state7;
			state8:			if (L & ~R) 		ns = state9;
								else if (R & ~L)	ns = state7;
								else 					ns = state8;
			state9:			if (L & ~R) 		ns = state0;
								else if (R & ~L) 	ns = state8;
								else 					ns = state9;
		endcase
   end
	
	assign LEDR = ps;
	
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= state5;
		else 
			ps <= ns;
	end
	
endmodule

module LED_control_testbench();
	logic L, R, Clock, Reset;
	logic [9:0] LEDR;
	
	LED_control dut (.LEDR, .L, .R, .Clock, .Reset);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	initial begin
		Reset <= 0;					@(posedge Clock);
		Reset <= 1;					@(posedge Clock);
		L <= 1;	R <= 0;			@(posedge Clock);
		L <= 1;	R <= 0;			@(posedge Clock);
		L <= 1;	R <= 0;			@(posedge Clock);
		L <= 1;	R <= 0;			@(posedge Clock);
		L <= 1;	R <= 0;			@(posedge Clock);
		Reset <= 1;					@(posedge Clock);
		L <= 0;	R <= 1;			@(posedge Clock);
		L <= 0;	R <= 1;			@(posedge Clock);
		L <= 0;	R <= 1;			@(posedge Clock);
		L <= 0;	R <= 1;			@(posedge Clock);
		L <= 0;	R <= 1;			@(posedge Clock);
		L <= 0;	R <= 1;			@(posedge Clock);
		$stop();
	end

endmodule

	
	
			
			
								
	
	
	