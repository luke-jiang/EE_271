module seg7 (bcd, leds);
      input  logic  [2:0] bcd;
      output logic  [6:0] leds;
      always_comb begin
         case (bcd)
            //          Light: 6543210
            3'b000: leds = ~7'b0111111; // 0
            3'b001: leds = ~7'b0000110; // 1
            3'b010: leds = ~7'b1011011; // 2
            3'b011: leds = ~7'b1001111; // 3
            3'b100: leds = ~7'b1100110; // 4
            3'b101: leds = ~7'b1101101; // 5
            3'b110: leds = ~7'b1111101; // 6
            3'b111: leds = ~7'b0000111; // 7
            default: leds = 7'b0000000;
endcase end
endmodule

module seg7_testbench();
	logic [3:0] bcd;
	logic [6:0] leds;
	
	seg7 dut (.bcd, .leds);
	
	integer i;
	initial begin
		for (i = 0; i < 10; i++) begin
			bcd = i;
			#10;
		end
	end
endmodule
