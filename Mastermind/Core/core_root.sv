

/*
Core root module containing and connecting all the modules with game logic.
*/


module core_root(
    input logic clk, rst,

    input logic [4:0] command,

    input logic [3:0] grid_read_x, comp_read_x,
    input logic [2:0] grid_read_y, comp_read_y,

    output logic [3:0] grid_read_data, comp_read_data,
    
    output logic [3:0] current_color,
    output logic [3:0] current_column,
    output logic [1:0] current_row,
    
    output logic [3:0] rnd_col_1, rnd_col_2, rnd_col_3, rnd_col_4);

    // Internal signal declaration
    logic [3:0] grid_write_x, comp_write_x;
    logic [1:0] grid_write_y, comp_write_y;
    logic [3:0] grid_write_data, comp_write_data;
    logic grid_write_enable, comp_write_enable;

    // Structurally connecting the modules
    state_tracker state_tracker_mod(
        .clk(clk),.rst(rst),
        .command(command),
        .write_x(grid_write_x),.write_y(grid_write_y),
        .write_data(grid_write_data),
        .write_enable(grid_write_enable),
        .current_color(current_color),
        .current_column(current_column),
        .current_row(current_row));

    grid_RAM grid_RAM_mod(
        .clk(clk),.rst(rst),
        .write_x(grid_write_x),.write_y(grid_write_y),
        .write_data(grid_write_data),
        .write_enable(grid_write_enable),
        .read_x(grid_read_x),.read_y(grid_read_y),
        .read_data(grid_read_data));

    comparison_RAM comp_RAM_mod(
        .clk(clk),.rst(rst),
        .write_x(comp_write_x),.write_y(comp_write_y),
        .write_data(comp_write_data),
        .write_enable(comp_write_enable),
        .read_x(comp_read_x),.read_y(comp_read_y),
        .read_data(comp_read_data));

    random_solution random_sol_mod(
        .clk(clk),.rst(rst),
        .command(command),
        .rnd_col_1(rnd_col_1),.rnd_col_2(rnd_col_2),
        .rnd_col_3(rnd_col_3),.rnd_col_4(rnd_col_4));

endmodule