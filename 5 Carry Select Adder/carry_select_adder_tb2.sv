module carry_select_adder_tb();
  reg  [3:0] in1;
  reg  [3:0] in2;
  reg        cin;
  wire [3:0] sum;
  wire       cout;

  carry_select_adder_3 dut(.a(in1), .b(in2), .cin(cin), .sum(sum), .cout(cout));

  integer i;
  reg [4:0] expected;   // 5-bit: sum + carry

  initial begin
    repeat(20) begin
      in1 = $random;
      in2 = $random;
      cin = $random;

      #1;  // let DUT settle

      expected = in1 + in2 + cin;

      if ({cout, sum} === expected)
        $display("PASS  in1=%b in2=%b cin=%b  -> sum=%b cout=%b",
                  in1,    in2,    cin,        sum,   cout);
      else
        $display("FAIL  in1=%b in2=%b cin=%b  -> sum=%b cout=%b  expected=%b",
                  in1,    in2,    cin,        sum,   cout,        expected);
    end

    $finish;
  end
endmodule
