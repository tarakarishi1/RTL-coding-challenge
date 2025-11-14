// 4X1 mux

/////////////////
// using 2X1 mux
/////////////////

module mux2to1(
	input a,b,sel,
	output out);
  
  assign out = sel?b:a;
endmodule

module mux4to1_using_mux2to1(
	input in1,in2,in3,in4,sel1,sel2,
	output out);
  
  wire w1,w2;
  
  mux2to1 m1(in1,in2,sel1, w1);
  mux2to1 m2(in3,in4,sel1, w2);
  mux2to1 m3(w1,w2,sel2, out);
endmodule




/////////////////
//Using case
/////////////////
module mux4to1_using_case(
	input in1,in2,in3,in4,sel1,sel2,
	output reg out);
  always@(*) begin
    case({sel2, sel1})
      2'b00: out = in1;
      2'b01: out = in2;
      2'b10: out = in3;
      2'b11: out = in4;
    endcase
  end
endmodule