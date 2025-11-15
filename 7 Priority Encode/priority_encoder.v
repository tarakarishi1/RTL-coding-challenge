module priority_encoder_using_casex( 
    input [7:0] in, 
    input en,
    output reg [2:0] out, 
    output reg valid  );   

    always@(*) begin
        if (en) begin
            casex(in)
            8'b1xxx_xxxx : begin out = 3'b111; valid = 1'b1; end
            8'b01xx_xxxx : begin out = 3'b110; valid = 1'b1; end
            8'b001x_xxxx : begin out = 3'b101; valid = 1'b1; end
            8'b0001_xxxx : begin out = 3'b100; valid = 1'b1; end
            8'b0000_1xxx : begin out = 3'b011; valid = 1'b1; end
            8'b0000_01xx : begin out = 3'b010; valid = 1'b1; end
            8'b0000_001x : begin out = 3'b001; valid = 1'b1; end
            8'b0000_0001 : begin out = 3'b000; valid = 1'b1; end
            8'b0000_0000 : begin out = 3'b000; valid = 1'b0; end
            endcase
        end
        else
        begin out = 3'b0; valid = 1'b0; end
    end
endmodule


module priority_encoder_using_if_else( 
    input [7:0] in, 
    inout en,
    output reg [2:0] out, 
    output reg valid  );

    always@(*) begin
        if(en) begin
            if(in>0) begin
                valid = 1'b1;

                if      (in[7]) out = 3'b111;
                else if (in[6]) out = 3'b110;
                else if (in[5]) out = 3'b101;
                else if (in[4]) out = 3'b100;
                else if (in[3]) out = 3'b011;
                else if (in[2]) out = 3'b010;
                else if (in[1]) out = 3'b001;
                else if (in[0]) out = 3'b000;

            end
            
            else begin
                out = 3'b000;
                valid = 1'b0;
            end

        end
        else begin 

            out = 3'b0; 
            valid = 1'b0;
        end


    end   
    
endmodule