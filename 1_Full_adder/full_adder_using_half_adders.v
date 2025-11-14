// Full adder using half Adders

module full_adder_using_half_adders(input A,B,C, output Sum,Carry);
  wire S1,C1,C2;
  half_adder h1(A,B,S1, C1);
  half_adder h2(S1, C, Sum, C2);
  assign Carry = C1 | C2;
endmodule
