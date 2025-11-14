

//Full_ADDER
module full_adder(input a,b,cin, output s,cout);
  assign s    = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);
endmodule


//MUX
module mux(input i1, i2, sel, output out);
  assign out = sel ? i2 : i1;
endmodule



//CARRY_SELECT_1

module carry_select_adder_1(
  input  [3:0] a, b,
  input        cin,
  output [3:0] sum,
  output       cout
);
  wire [3:0] s0, s1;
  wire [3:0] c0, c1;

  // chain for cin = 0
  full_adder f0_0(a[0], b[0], 1'b0,  s0[0], c0[0]);
  full_adder f0_1(a[1], b[1], c0[0], s0[1], c0[1]);
  full_adder f0_2(a[2], b[2], c0[1], s0[2], c0[2]);
  full_adder f0_3(a[3], b[3], c0[2], s0[3], c0[3]);

  // chain for cin = 1  (use c1 chain, not c0)
  full_adder f1_0(a[0], b[0], 1'b1,  s1[0], c1[0]);
  full_adder f1_1(a[1], b[1], c1[0], s1[1], c1[1]);
  full_adder f1_2(a[2], b[2], c1[1], s1[2], c1[2]);
  full_adder f1_3(a[3], b[3], c1[2], s1[3], c1[3]);

  // select by external cin
  assign sum  = cin ? s1    : s0;
  assign cout = cin ? c1[3] : c0[3];
endmodule




//CARRY_SELECT_2

// 4-bit carry-select adder: lower 2 ripple, upper 2 precompute
module carry_select_adder_2(
  input  [3:0] a, b,
  input        cin,
  output [3:0] sum,
  output       cout
);
  // lower 2 bits with true cin
  wire c1, c2;
  full_adder fa0(a[0], b[0], cin,  sum[0], c1);
  full_adder fa1(a[1], b[1], c1,   sum[1], c2);

  // upper 2 bits precompute for carry=0
  wire s20, s30, c20, c30;
  full_adder fa2_c0(a[2], b[2], 1'b0, s20, c20);
  full_adder fa3_c0(a[3], b[3], c20,  s30, c30);

  // upper 2 bits precompute for carry=1
  wire s21, s31, c21, c31;
  full_adder fa2_c1(a[2], b[2], 1'b1, s21, c21);
  full_adder fa3_c1(a[3], b[3], c21,  s31, c31);

  // select using carry out of lower block (c2)
  assign sum[2] = c2 ? s21 : s20;
  assign sum[3] = c2 ? s31 : s30;
  assign cout   = c2 ? c31 : c30;
endmodule






// carry_select_3: 4 split
module carry_select_adder_3(
  input  [3:0] a, 
  input  [3:0] b, 
  input        cin, 
  output [3:0] sum, 
  output       cout
);
  // Precompute sums and carries for both possible carry-ins (0 and 1)
  wire s0_0, s0_1, s0_2, s0_3;
  wire s1_0, s1_1, s1_2, s1_3;
  wire c0_0, c0_1, c0_2, c0_3;
  wire c1_0, c1_1, c1_2, c1_3;

  // Cin = 0
  full_adder fa0_0(a[0], b[0], 1'b0, s0_0, c0_0);
  full_adder fa0_1(a[1], b[1], 1'b0, s0_1, c0_1);
  full_adder fa0_2(a[2], b[2], 1'b0, s0_2, c0_2);
  full_adder fa0_3(a[3], b[3], 1'b0, s0_3, c0_3);

  // Cin = 1
  full_adder fa1_0(a[0], b[0], 1'b1, s1_0, c1_0);
  full_adder fa1_1(a[1], b[1], 1'b1, s1_1, c1_1);
  full_adder fa1_2(a[2], b[2], 1'b1, s1_2, c1_2);
  full_adder fa1_3(a[3], b[3], 1'b1, s1_3, c1_3);

  // Selected carries
  wire csel_0, csel_1, csel_2, csel_3;

  // --- Bit 0 ---
  mux mux_s0 (.i1(s0_0), .i2(s1_0), .sel(cin), .out(sum[0]));
  mux mux_c0 (.i1(c0_0), .i2(c1_0), .sel(cin), .out(csel_0));

  // --- Bit 1 ---
  mux mux_s1 (.i1(s0_1), .i2(s1_1), .sel(csel_0), .out(sum[1]));
  mux mux_c1 (.i1(c0_1), .i2(c1_1), .sel(csel_0), .out(csel_1));

  // --- Bit 2 ---
  mux mux_s2 (.i1(s0_2), .i2(s1_2), .sel(csel_1), .out(sum[2]));
  mux mux_c2 (.i1(c0_2), .i2(c1_2), .sel(csel_1), .out(csel_2));

  // --- Bit 3 ---
  mux mux_s3 (.i1(s0_3), .i2(s1_3), .sel(csel_2), .out(sum[3]));
  mux mux_c3 (.i1(c0_3), .i2(c1_3), .sel(csel_2), .out(csel_3));

  assign cout = csel_3;
endmodule
