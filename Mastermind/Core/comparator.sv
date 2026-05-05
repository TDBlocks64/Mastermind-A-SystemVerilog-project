

/*
Comparator module which compares the player's guess with the randomly generated code
Writes to the comparison RAM based on the comparison results.
*/


module comparator(
    input logic clk, module_enable,

    input logic [3:0] current_column,
    input logic [3:0] rnd_col_1, rnd_col_2, rnd_col_3, rnd_col_4,
    input logic [3:0] grid_read_data,
    
    output logic [3:0] grid_read_x,
    output logic [1:0] grid_read_y,

    output logic [3:0] comp_write_x,
    output logic [1:0] comp_write_y,
    output logic [3:0] comp_write_data,
    output logic comp_write_enable);

    always_ff @(posedge clk) begin
        grid_read_x <= 4'b0000;
        grid_read_y <= 3'b000;
        comp_write_x <= 4'b0000;
        comp_write_y <= 2'b00;
        comp_write_data <= 4'b0000;
        comp_write_enable <= 1'b0;

        if (module_enable) begin
            comp_write_data <= 2'b00;
            comp_write_enable <= 1'b0;
            grid_read_x <= current_column;
            comp_write_x <= current_column;
            for (row = 0; row <= 3; row++) begin
                case (row)
                    2'b00: begin
                        grid_read_y <= row;
                        comp_write_y <= row;
                        if (grid_read_data == rnd_col_1) begin
                            comp_write_data <= 2'b10;
                            comp_write_enable <= 1'b1;
                        end
                        else if ((grid_read_data == rnd_col_2) ||
                            (grid_read_data == rnd_col_3) ||
                            (grid_read_data == rnd_col_4)) begin
                                comp_write_data <= 2'b01;
                                comp_write_enable <= 1'b1;
                        end
                    end
                    2'b01: begin
                        grid_read_y <= row;
                        comp_write_y <= row;
                        if (grid_read_data == rnd_col_2) begin
                            comp_write_data <= 2'b10;
                            comp_write_enable <= 1'b1;
                        end
                        else if ((grid_read_data == rnd_col_1) ||
                            (grid_read_data == rnd_col_3) ||
                            (grid_read_data == rnd_col_4)) begin
                                comp_write_data <= 2'b01;
                                comp_write_enable <= 1'b1;
                        end
                    end
                    2'b10: begin
                        grid_read_y <= row;
                        comp_write_y <= row;
                        if (grid_read_data == rnd_col_3) begin
                            comp_write_data <= 2'b10;
                            comp_write_enable <= 1'b1;
                        end
                        else if ((grid_read_data == rnd_col_1) ||
                            (grid_read_data == rnd_col_2) ||
                            (grid_read_data == rnd_col_4)) begin
                                comp_write_data <= 2'b01;
                                comp_write_enable <= 1'b1;
                        end
                    end
                    2'b11: begin
                        grid_read_y <= row;
                        comp_write_y <= row;
                        if (grid_read_data == rnd_col_4) begin
                            comp_write_data <= 2'b10;
                            comp_write_enable <= 1'b1;
                        end
                        else if ((grid_read_data == rnd_col_1) ||
                            (grid_read_data == rnd_col_2) ||
                            (grid_read_data == rnd_col_3)) begin
                                comp_write_data <= 2'b01;
                                comp_write_enable <= 1'b1;
                        end
                    end
                endcase
            end
        end
    end

endmodule