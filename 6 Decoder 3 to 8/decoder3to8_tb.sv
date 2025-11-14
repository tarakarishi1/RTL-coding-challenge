module decoder3to8_tb;
  reg [2:0] in ;
  reg en;
  wire [7:0] out;
    decoder3to8_using_shift_operator dut (.in(in), .en(en), .out(out));
    //decoder3to8_using_case dut (.in(in), .en(en), .out(out));
    initial begin
        $display("Enable | Input |  output");
        $display("----------------------------");
        
        repeat(2) begin
        en = 1'b0;
        in = $urandom_range(0,7);
            #1;
            $display("%b      | %b   |  %b", en, in, out);
        end

        repeat(20) begin
        en = 1'b1;
        in = $urandom_range(0,7);
            #1;
            $display("%b      | %b   |  %b", en, in, out);
        end
        $finish;  
    end
endmodule