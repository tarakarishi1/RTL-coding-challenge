
module carry_select_adder_tb();
  logic [3:0]in1;
  logic [3:0]in2;
  logic [3:0]sum;
  logic cin, cout;
  
  //carry_select_adder_1 dut(.a(in1), .b(in2), .cin(cin), .sum(sum), .cout(cout));
  //carry_select_adder_2 dut(.a(in1), .b(in2), .cin(cin), .sum(sum), .cout(cout));
  carry_select_adder_3 dut(.a(in1), .b(in2), .cin(cin), .sum(sum), .cout(cout));
  
  initial begin
    in1 = 4'b1110;
    in2 = 4'b1010;
    cin = 1'b1;
    #5;
    assert((sum == 4'b1001)&&(cout == 1'b1))
      $display("Pass: Carry:%0b, Sum: %0b",cout,sum);
    else
      $display("Fail: Carry:%0b, Sum: %0b",cout,sum);
      
  end
endmodule