

/*
Color decoder module to turn the 4-bit encoded color signal to RGB components
visible signal to ensure only the visible part of the screen will get RGB signals
*/


module color_decoder(
    input logic [3:0] color,
    input logic visible,

    output logic [3:0] vgaRed, vgaGreen, vgaBlue);

    // Color signal to RGB signals converter
    always_comb begin
        if (visible) begin
            case (color)
                4'b0000: begin vgaRed=4'b0000; vgaGreen=4'b0000; vgaBlue=4'b0000; end // Black, not strictly necessary

                4'b0001: begin vgaRed=4'b1111; vgaGreen=4'b0000; vgaBlue=4'b0000; end // Red
                4'b0010: begin vgaRed=4'b1111; vgaGreen=4'b1000; vgaBlue=4'b0000; end // Orange
                4'b0011: begin vgaRed=4'b1111; vgaGreen=4'b1111; vgaBlue=4'b0000; end // Yellow
                4'b0100: begin vgaRed=4'b0000; vgaGreen=4'b1111; vgaBlue=4'b0000; end // Green
                4'b0101: begin vgaRed=4'b0000; vgaGreen=4'b1111; vgaBlue=4'b1111; end // Cyan
                4'b0110: begin vgaRed=4'b0000; vgaGreen=4'b0000; vgaBlue=4'b1111; end // Blue
                4'b0111: begin vgaRed=4'b1010; vgaGreen=4'b0000; vgaBlue=4'b1111; end // Purple
                4'b1000: begin vgaRed=4'b1111; vgaGreen=4'b0000; vgaBlue=4'b1111; end // Pink

                4'b1100: begin vgaRed=4'b0100; vgaGreen=4'b0100; vgaBlue=4'b0100; end // Gray
                4'b1110: begin vgaRed=4'b1000; vgaGreen=4'b0100; vgaBlue=4'b0000; end // Brown
                4'b1111: begin vgaRed=4'b1111; vgaGreen=4'b1111; vgaBlue=4'b1111; end // White

                default: begin vgaRed=4'b0000; vgaGreen=4'b0000; vgaBlue=4'b0000; end // Black
            endcase
        end else begin
            begin vgaRed=4'b0000; vgaGreen=4'b0000; vgaBlue=4'b0000; end // Default color: Black
        end
    end

endmodule