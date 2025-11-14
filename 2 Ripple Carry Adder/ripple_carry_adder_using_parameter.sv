`timescale 1ns/1ps

module ripple_carry_adder_tb;
  parameter N = 8;

  // DUT signals
  logic [N-1:0] a, b;
  logic         cin;
  logic [N-1:0] sum;
  logic         cout;
  int expected_sum ;
  bit expected_cout;
  int i;

  // Instantiate DUT
  ripple_carry_adder_using_parameter #(.N(N)) dut (
    .a(a), .b(b), .cin(cin),
    .sum(sum), .cout(cout)
  );

  // Simulation block
  initial begin
    $dumpfile("ripple_carry_adder.vcd");
    $dumpvars(0, ripple_carry_adder_tb);

    $display("Time |       A |       B | CIN |     SUM | COUT | Expected SUM | Expected COUT");
    $display("--------------------------------------------------------------------------");

    // Loop through test cases
    for (i = 0; i < 16; i++) begin
      a   = $urandom_range(0, 2**N - 1);
      b   = $urandom_range(0, 2**N - 1);
      cin = i % 2;
      #5;
      expected_sum  = a + b + cin;
      expected_cout = (expected_sum >> N);
      expected_sum = expected_sum & ((1 << N) - 1);

      $display("%4t | %8b | %8b |  %0b  | %8b |  %0b  |    %8b    |       %0b",
               $time, a, b, cin, sum, cout, expected_sum, expected_cout);
    end

    $finish;
  end
endmodule
