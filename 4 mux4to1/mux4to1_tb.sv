module mux4to1_tb();
  logic a,b,c,d,s1,s2,y;
  
  mux4to1_using_mux2to1 dut(a,b,c,d,s1,s2,y);
  //mux4to1_using_case dut(a,b,c,d,s1,s2,y);
  initial begin
    a = 1;
    b = 1;
    c = 0;
    d = 1;
    
    for (int j = 0 ; j<4; j++) begin
      {s2,s1} = j[1:0];
      #2 $display("out:%0b",y);
    end
  end
  
endmodule