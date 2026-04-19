

/*
Static color selection module showing the different color options that can be used.
Uses the counter framework provided by the sync_generator module to combinationally write the color signal.
*/


module static_color_selection(
    input logic [10:0] h_count,
    input logic [9:0] v_count,

    output logic [3:0] selection_color);

    // Color selection display
    always_comb begin
        if (((h_count >= 60) && (h_count <= 140)) && 
            ((v_count >= 120) && (v_count <= 200))) begin
            selection_color = 4'b1100; // Cross TODO: Change to a cross
        end 
        else if (((h_count >= 180) && (h_count <= 260)) &&
            ((v_count >= 120) && (v_count <= 200))) begin
            selection_color = 4'b0001; // Red
        end 
        else if (((h_count >= 300) && (h_count <= 380)) &&
            ((v_count >= 120) && (v_count <= 200))) begin
            selection_color = 4'b0010; // Orange
        end 
        else if (((h_count >= 420) && (h_count <= 500)) &&
            ((v_count >= 120) && (v_count <= 200))) begin 
            selection_color = 4'b0011; // Yellow
        end 
        else if (((h_count >= 540) && (h_count <= 620)) &&
            ((v_count >= 120) && (v_count <= 200))) begin
            selection_color = 4'b0100; // Green
        end 
        else if (((h_count >= 660) && (h_count <= 740)) &&
            ((v_count >= 120) && (v_count <= 200))) begin 
            selection_color = 4'b0101; // Cyan
        end 
        else if (((h_count >= 780) && (h_count <= 860)) &&
            ((v_count >= 120) && (v_count <= 200))) begin 
            selection_color = 4'b0110; // Blue
        end 
        else if (((h_count >= 900) && (h_count <= 980)) &&
            ((v_count >= 120) && (v_count <= 200))) begin 
            selection_color = 4'b0111; // Purple
        end 
        else if (((h_count >= 1020) && (h_count <= 1100)) &&
            ((v_count >= 120) && (v_count <= 200))) begin // Pink
            selection_color = 4'b1000;
        end 
        else if (((h_count >= 1140) && (h_count <= 1220)) &&
            ((v_count >= 120) && (v_count <= 200))) begin // Confirm
            selection_color = 4'b1100; // TODO: Change to confirmation sign
        end 
        else begin
            selection_color = 4'b0000; // Default color: Black
        end
    end
endmodule