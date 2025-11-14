// Half subtractor


module half_subtractor(input a,b, output diff,borr);
  assign diff = a^b;
  assign borr = (~a)&b;
endmodule


// Gate level

module half_subtractor_gate(input a, b, output diff, borr);
  wire na;
  not (na, a);         // na = ~a
  xor (diff, a, b);    // diff = a ^ b
  and (borr, na, b);   // borr = ~a & b
endmodule



// Behavioral using always block
module half_subtractor_beh(input a, b, output reg diff, borr);
  always @(*) begin
    diff = a ^ b;
    borr = (~a) & b;
  end
endmodule


//Behavioral using case
module half_subtractor_case(input a, b, output reg diff, borr);
  always @(*) begin
    case ({a, b})
      2'b00: begin diff = 0; borr = 0; end
      2'b01: begin diff = 1; borr = 1; end
      2'b10: begin diff = 1; borr = 0; end
      2'b11: begin diff = 0; borr = 0; end
    endcase
  end
endmodule


//Structural Modeling using small gates and submodels
module inv(input x, output y);
  assign y = ~x;
endmodule

module and2(input x, y, output z);
  assign z = x & y;
endmodule

module xor2(input x, y, output z);
  assign z = x ^ y;
endmodule

module half_subtractor_struct(input a, b, output diff, borr);
  wire na;
  inv U1 (.x(a), .y(na));
  xor2 U2 (.x(a), .y(b), .z(diff));
  and2 U3 (.x(na), .y(b), .z(borr));
endmodule
