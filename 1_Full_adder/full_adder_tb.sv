module full_adder_tb();
  logic i1,i2,i3,S,C;
  int j;
  
  full_adder_using_half_adders dut (.A(i1), .B(i2), .C(i3), .Sum(S), .Carry(C));
  initial begin
    for (j=0; j<8; j++) begin
      {i1,i2,i3} = j[2:0];
      #1;
      assert((S == i1^i2^i3) && (C == ((i1&i2)|(i2&i3)|(i3&i1))))
        $display("PASS");
      else
        $display("FAIL: %0d,%0d, %0d", i1, i2, i3);
    end
  end
  
endmodule
