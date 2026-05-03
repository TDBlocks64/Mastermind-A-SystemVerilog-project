

/*
Output root module containing and connecting all the modules that handle output signals.
*/


module output_root(
    input logic clk, rst,
    
    input logic [3:0] current_color,
    input logic [3:0] current_column,
    input logic [1:0] current_row,

    input logic show_solution,

    input logic [3:0] rnd_col_1, rnd_col_2, rnd_col_3, rnd_col_4,

    input logic [3:0] grid_read_data, comp_read_data,

    output logic [3:0] grid_read_x, comp_read_x,
    output logic [2:0] grid_read_y, comp_read_y,

    output logic h_sync, v_sync,
    output logic [3:0] vgaRed, vgaGreen, vgaBlue);



    // Internal signal declaration
    logic [10:0] h_count;
    logic [9:0] v_count;

    logic visible;

    logic select_color, grid_color;
    logic [3:0] selection_color, solution_color;
    logic [3:0] color;



    // Structurally connecting the modules
    sync_gen_720p sync_gen_mod(
        .clk(clk),.rst(rst),
        .h_count(h_count),.v_count(v_count),
        .h_sync(h_sync),.v_sync(v_sync),
        .visible(visible),
        .handshake_output(handshake_output));



    static_color_selection static_color_selection_mod(
        .h_count(h_count),.v_count(v_count),
        .selection_color(selection_color));

    color_selector color_selector_mod(
        .h_count(h_count),.v_count(v_count),
        .current_color(current_color),
        .select_color(select_color));

    grid_selector grid_selector_mod(
        .h_count(h_count),.v_count(v_count),
        .current_column(current_column),
        .current_row(current_row),
        .grid_color(grid_color));



    grid_display grid_display_mod(
        .h_count(h_count),.v_count(v_count),
        .read_x(grid_read_x),.read_y(grid_read_y));

    comparison_display comp_display_mod(
        .h_count(h_count),.v_count(v_count),
        .read_x(comp_read_x),.read_y(comp_read_y));

    solution_display solution_display_mod(
        .h_count(h_count),.v_count(v_count),
        .show_solution(show_solution),
        .rnd_col_1(rnd_col_1),.rnd_col_2(rnd_col_2),
        .rnd_col_3(rnd_col_3),.rnd_col_4(rnd_col_4),
        .solution_color(solution_color));



    color_prioritizer color_prioritizer_mod(
        .rst(rst),
        .select_color(select_color),
        .grid_color(grid_color),
        .selection_color(selection_color),
        .solution_color(solution_color),
        .grid_read_data(grid_read_data),
        .comp_read_data(comp_read_data),
        .color(color));

    color_decoder color_decoder_mod(
        .color(color),
        .visible(visible),
        .vgaRed(vgaRed),.vgaGreen(vgaGreen),.vgaBlue(vgaBlue));

endmodule