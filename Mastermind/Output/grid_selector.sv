module grid_selector(
    input logic [10:0] h_count,
    input logic [9:0] v_count,

    input logic [3:0] current_column,
    input logic [1:0] current_row,

    output logic grid_color);

    always_comb begin
        grid_color = 1'b0;
        case (current_row)
            2'b00: begin // First column from above selected
                if ((((h_count >= (current_column*120 + 65)) && (h_count <= (current_column*120 + 135))) &&
                    (((v_count >= 225) && (v_count < 230)) ||
                    ((v_count > 290) && (v_count <= 295)))) ||
                    ((((h_count >= (current_column*120 + 65)) && (h_count < (current_column*120 + 70))) ||
                    ((h_count > (current_column*120 + 130)) && (h_count <= (current_column*120 + 135)))) &&
                    ((v_count >= 230) && (v_count <= 290)))) begin
                        grid_color = 1'b1;
                    end
            end
            2'b01: begin // Second column from above selected
                if ((((h_count >= (current_column*120 + 65)) && (h_count <= (current_column*120 + 135))) &&
                    (((v_count >= 325) && (v_count < 330)) ||
                    ((v_count > 390) && (v_count <= 395)))) ||
                    ((((h_count >= (current_column*120 + 65)) && (h_count < (current_column*120 + 70))) ||
                    ((h_count > (current_column*120 + 130)) && (h_count <= (current_column*120 + 135)))) &&
                    ((v_count >= 330) && (v_count <= 390)))) begin
                        grid_color = 1'b1;
                    end
            end
            2'b10: begin // Third column from above selected
                if ((((h_count >= (current_column*120 + 65)) && (h_count <= (current_column*120 + 135))) &&
                    (((v_count >= 425) && (v_count < 430)) ||
                    ((v_count > 490) && (v_count <= 495)))) ||
                    ((((h_count >= (current_column*120 + 65)) && (h_count < (current_column*120 + 70))) ||
                    ((h_count > (current_column*120 + 130)) && (h_count <= (current_column*120 + 135)))) &&
                    ((v_count >= 430) && (v_count <= 490)))) begin
                        grid_color = 1'b1;
                    end
            end
            2'b11: begin // Fourth column from above selected
                if ((((h_count >= (current_column*120 + 65)) && (h_count <= (current_column*120 + 135))) &&
                    (((v_count >= 525) && (v_count < 530)) ||
                    ((v_count > 590) && (v_count <= 595)))) ||
                    ((((h_count >= (current_column*120 + 65)) && (h_count < (current_column*120 + 70))) ||
                    ((h_count > (current_column*120 + 130)) && (h_count <= (current_column*120 + 135)))) &&
                    ((v_count >= 530) && (v_count <= 590)))) begin
                        grid_color = 1'b1;
                    end
            end
            default: begin grid_color = 1'b0; end
        endcase
    end
endmodule