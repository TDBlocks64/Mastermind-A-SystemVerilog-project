

/*
Comparison display module which reads the comparison RAM module in the core.
By only reading the RAM within specific parts of the screen can the data within the RAM be visualized.
*/


module comparison_display(
    input logic [10:0] h_count,
    input logic [9:0] v_count,

    output logic [3:0] read_x,
    output logic [2:0] read_y);

    always_comb begin
        read_x = 4'd11; // Default out of bounds value
        read_y = 4'd5;  // Default out of bounds value

        for (int column = 0; column <= 9; column++) begin
            for (int row = 0; row <= 3; row++) begin
                if (((row == 0) || (row == 1)) &&
                    ((h_count >= ((column * 120) + 70)) &&
                    (h_count <= ((column * 120) + 90))) && 
                    ((v_count >= ((row * 40) + 630)) &&
                    (v_count <= ((row * 40) + 650)))) begin
                        read_x = column[3:0];
                        read_y = row[2:0];
                end
                if (((row == 2) || (row == 3)) &&
                    ((h_count >= ((column * 120) + 110)) &&
                    (h_count <= ((column * 120) + 130))) && 
                    ((v_count >= ((row * 40) + 630)) &&
                    (v_count <= ((row * 40) + 650)))) begin
                        read_x = column[3:0];
                        read_y = row[2:0];
                end
            end
        end
    end
endmodule