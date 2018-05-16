module Comparator(out, in1, in2, Clock, Reset);
	output logic out;
	input logic Clock, Reset;
	input logic [9:0] in1, in2;
	
	assign out = (in1 > in2);
endmodule

module Comparator_testbench();
	logic out;
	logic Clock, Reset;
	logic [9:0] in1, in2;
	
	Comparator dut (.out, .in1, .in2, .Clock, .Reset);
	
	initial begin
		Clock = 1; Reset = 0;
		in1 = 10'b0000000000;
		in2 = 10'b0000000000;
		#10;
		in1 = 10'b0000000001;
		in2 = 10'b0000000010;
		#10;
		in1 = 10'b0000000001;
		in2 = 10'b0000000000;
		#10;
	end
endmodule

		