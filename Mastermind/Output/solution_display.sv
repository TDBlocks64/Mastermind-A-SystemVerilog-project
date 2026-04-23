

/*
Solution display module to display the random solution generated within the core module.
The show_solution signal is used to show the solution when the game is over.
Uses the counter framework provided by the sync_generator module to combinationally write the color signal.
*/


module solution_display(
    input logic [10:0] h_count,
    input logic [9:0] v_count,

    input logic show_solution,

    input logic [3:0] rnd_col_1, rnd_col_2, rnd_col_3, rnd_col_4,

    output logic [3:0] solution_color);

    // Solution display
    always_comb begin
        if (show_solution) begin    // Only show the solution when this signal is high
            if (((h_count >= 790) && (h_count <= 850)) && 
                ((v_count >= 30) && (v_count <= 90))) begin
                solution_color = rnd_col_1;
            end
            else if (((h_count >= 910) && (h_count <= 970)) && 
                ((v_count >= 30) && (v_count <= 90))) begin
                solution_color = rnd_col_2;
            end
            else if (((h_count >= 1030) && (h_count <= 1090)) && 
                ((v_count >= 30) && (v_count <= 90))) begin
                solution_color = rnd_col_3;
            end
            else if (((h_count >= 1150) && (h_count <= 1210)) && 
                ((v_count >= 30) && (v_count <= 90))) begin
                solution_color = rnd_col_4;
            end
            else begin
                solution_color = 4'b0000;
            end
        end
        else begin
            solution_color = 4'b0000; // By default the solution is not visible, thus overwritten by the black color encoding.
        end
    end
endmodule