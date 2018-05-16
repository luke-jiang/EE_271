// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
  output logic  [6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  output logic  [9:0]    LEDR;
  input  logic  [3:0]    KEY;
  input  logic  [9:0]     SW;

  // detect discount and lights up LEDR[0] if true
  Discount disc (.out(LEDR[0]), .U(SW[9]), .P(SW[8]), .C(SW[7]));
  // detect stolen and light up LEDR[1] if true
  Stolen stol (.out(LEDR[1]), .U(SW[9]), .P(SW[8]), .C(SW[7]), .M(SW[1]));

  seg7_Instant two_seg7 (.SW(SW[7:0]), .HEX1(HEX1), .HEX0(HEX0));
  // Freds_Instant freds (HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, SW[9:7]);

endmodule

module DE1_SoC_testbench();
  logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  logic  [9:0] LEDR;
  logic  [3:0] KEY;
  logic  [9:0] SW;

  DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
  // Try all combinations of inputs.
  integer i;
  initial begin
    SW[9] = 1'b0;
    SW[8] = 1'b0;
    for(i = 0; i <256; i++) begin
      SW[9:7]= i;
      SW[0] = i;
      #10;
    end
  end
endmodule
