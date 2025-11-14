module ripple_carry_adder_using_parameter#(parameter N)(input [N-1:0]a,b, input cin, output [N-1:0]sum, output cout);
  
  wire [N:0]carr;
  assign cout = carr[N];
  assign carr[0] = cin;
  
  genvar i;
  generate
    for(i=0; i<N; i++)
      begin
        assign sum[i] = a[i]^b[i]^carr[i];
        assign carr[i+1] = (a[i]&b[i])|(b[i]&carr[i])|(carr[i]&a[i]);
      end
  endgenerate
endmodule
