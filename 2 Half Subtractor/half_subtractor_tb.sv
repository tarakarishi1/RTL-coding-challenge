
`timescale 1ns/1ps

module half_subtractor_tb;
  logic a,b;
  logic diff,borr;
  int i;
  
  half_subtractor dut(.a(a), .b(b), .diff(diff), .borr(borr));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #25 $finish;
  end
  
  initial begin
    $display(" A B | DIFF BORR | expD expB");
    for (i=0; i<4; i++) begin
      {a,b} = i[1:0];
        #5;
      assert( (diff == (a ^ b)) && (borr == ((~a) & b)) )
        $display(" %b %b |   %b    %b |   %b    %b  PASS",
                 a, b, diff, borr, (a^b), ((~a)&b));
        else
          $display(" %b %b |   %b    %b |   %b    %b  FAIL",
                 a, b, diff, borr, (a^b), ((~a)&b));
    end
  end
  
endmodule