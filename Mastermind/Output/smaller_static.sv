module smaller_static(
    input logic [10:0] h_count,
    input logic [9:0] v_count,

    output logic [3:0] small_color);

    always_comb begin // Color selection display
        if (((h_count >= 70) && (h_count <= 130)) && 
            ((v_count >= 230) && (v_count <= 290))) begin
            small_color = 4'b1100; // Cross TODO: Change to a cross
        end 
        else if (((h_count >= 190) && (h_count <= 250)) &&
            ((v_count >= 230) && (v_count <= 290))) begin
            small_color = 4'b0001; // Red
        end 
        else if (((h_count >= 310) && (h_count <= 370)) &&
            ((v_count >= 230) && (v_count <= 290))) begin
            small_color = 4'b0010; // Orange
        end 
        else if (((h_count >= 430) && (h_count <= 490)) &&
            ((v_count >= 230) && (v_count <= 290))) begin 
            small_color = 4'b0011; // Yellow
        end 
        else if (((h_count >= 550) && (h_count <= 610)) &&
            ((v_count >= 230) && (v_count <= 290))) begin
            small_color = 4'b0100; // Green
        end 
        else if (((h_count >= 670) && (h_count <= 730)) &&
            ((v_count >= 230) && (v_count <= 290))) begin 
            small_color = 4'b0101; // Cyan
        end 
        else if (((h_count >= 790) && (h_count <= 850)) &&
            ((v_count >= 230) && (v_count <= 290))) begin 
            small_color = 4'b0110; // Blue
        end 
        else if (((h_count >= 910) && (h_count <= 970)) &&
            ((v_count >= 230) && (v_count <= 290))) begin 
            small_color = 4'b0111; // Purple
        end 
        else if (((h_count >= 1030) && (h_count <= 1090)) &&
            ((v_count >= 230) && (v_count <= 290))) begin // Pink
            small_color = 4'b1000;
        end 
        else if (((h_count >= 1150) && (h_count <= 1210)) &&
            ((v_count >= 230) && (v_count <= 290))) begin // Confirm
            small_color = 4'b1100; // TODO: Change to confirmation sign
        end 
        else begin
            small_color = 4'b0000;
        end
    end
endmodule