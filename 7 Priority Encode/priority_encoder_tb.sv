`timescale 1ns/1ps

module priority_encoder_tb;

    // drive signals from TB → use variables
    reg [7:0] in;
    reg       en;
    wire       valid;
    wire [2:0] out;

    // use named port connections to avoid any confusion
    priority_encoder_using_casex dut (
        .in   (in),
        .en   (en),
        .out  (out),
        .valid(valid)
    );
    //priority_encoder_using_if_else dut (...);

    initial begin
        en = 1'b0;
        in = '0;

        $display("En |  Input   | Output | Valid");
        $display("--------------------------------");

        #5;
        repeat (2) begin
            in = $random;
            #1;
            $display("%b | %b | %b | %b", en, in, out, valid);
        end

        #5 en = 1'b1;
        repeat (20) begin
            in = $random;
            #1;
            $display("%b | %b | %b | %b", en, in, out, valid);
        end

        #10 $finish;
    end

endmodule
