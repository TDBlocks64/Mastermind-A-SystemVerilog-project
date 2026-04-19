

/*
Color prioritizer module that takes the color signals of the various submodules.
These color signals are used in priority encoding and drive the color signal.
This module prevents multiple signals driving one signal.
*/


module color_prioritizer(
    input logic rst,
    input logic select_color, grid_color,
    input logic [3:0] selection_color, read_data,

    output logic [3:0] color);

    // Internal signals, 1 bit -> 4 bit
    logic [3:0] intern_select_color, intern_grid_color;

    // Assign values to internal signals
    assign intern_select_color = {select_color, select_color, select_color, select_color};
    assign intern_grid_color = {grid_color, grid_color, grid_color, grid_color};

    // Priority encoder
    always_comb begin
        if (rst) color = 4'b0000;
        else if (selection_color != 4'b0000) color = selection_color;
        else if (intern_select_color != 4'b0000) color = intern_select_color;
        else if (intern_grid_color != 4'b0000) color = intern_grid_color;
        else if (read_data != 4'b0000) color = read_data;
        else color = 4'b0000;
    end
endmodule