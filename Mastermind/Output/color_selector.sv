

/*
Color selector module which visualizes which of the colors is currently selected.
Uses the counter framework provided by the sync_generator module to combinationally write the color signal.
*/


module color_selector(
    input logic [10:0] h_count,
    input logic [9:0] v_count,

    input logic [3:0] current_color,

    output logic select_color);

    // Selected color visualization
    always_comb begin
        select_color = 1'b0;
        case (current_color)
            4'b0000: begin // No color selected
                if ((((h_count >= 55) && (h_count <= 145)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 55) && (h_count < 60)) ||
                    ((h_count > 140) && (h_count <= 145))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b0001: begin // Red selected
                if ((((h_count >= 175) && (h_count <= 265)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 175) && (h_count < 180)) ||
                    ((h_count > 260) && (h_count <= 265))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b0010: begin // Orange selected
                if ((((h_count >= 295) && (h_count <= 385)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 295) && (h_count < 300)) ||
                    ((h_count > 380) && (h_count <= 385))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b0011: begin // Yellow selected
                if ((((h_count >= 415) && (h_count <= 505)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 415) && (h_count < 420)) ||
                    ((h_count > 500) && (h_count <= 505))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b0100: begin // Green selected
                if ((((h_count >= 535) && (h_count <= 625)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 535) && (h_count < 540)) ||
                    ((h_count > 620) && (h_count <= 625))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b0101: begin // Cyan selected
                if ((((h_count >= 655) && (h_count <= 745)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 655) && (h_count < 660)) ||
                    ((h_count > 740) && (h_count <= 745))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b0110: begin // Blue selected
                if ((((h_count >= 775) && (h_count <= 865)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 775) && (h_count < 780)) ||
                    ((h_count > 860) && (h_count <= 865))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b0111: begin // Purple selected
                if ((((h_count >= 895) && (h_count <= 985)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 895) && (h_count < 900)) ||
                    ((h_count > 980) && (h_count <= 985))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b1000: begin // Pink selected
                if ((((h_count >= 1015) && (h_count <= 1105)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 1015) && (h_count < 1020)) ||
                    ((h_count > 1100) && (h_count <= 1105))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            4'b1001: begin // Confirmation selected
                if ((((h_count >= 1135) && (h_count <= 1225)) &&
                    (((v_count >= 115) && (v_count < 120)) ||
                    ((v_count > 200) && (v_count <= 205)))) ||
                    ((((h_count >= 1135) && (h_count < 1140)) ||
                    ((h_count > 1220) && (h_count <= 1225))) &&
                    ((v_count >= 120) && (v_count <= 200)))) begin
                        select_color = 1'b1;
                    end
            end
            default: begin select_color = 1'b0; end // Default color: Black
        endcase
    end

endmodule