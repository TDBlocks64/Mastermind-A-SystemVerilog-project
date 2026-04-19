

/*
This file contains the top level module of this project.
Full system root module connecting the submodules of the system together.
Also contains a clocking wizard module from the Vivado IP Catalog.
*/


module full_system_root(
    input logic clk_100MHz, rst,

    input logic [4:0] buttons_in,

    output logic h_sync, v_sync,
    output logic [3:0] vgaRed, vgaGreen, vgaBlue);

    // Internal signal declaration
    logic clk, handshake_input;

    logic [4:0] command;

    logic [3:0] current_color;
    logic [3:0] current_column;
    logic [1:0] current_row;

    logic [3:0] read_x;
    logic [2:0] read_y;
    logic [3:0] read_data;

    // Structurally connecting the modules
    clk_wiz_0 clk_wiz_mod(
        .clk_in1(clk_100MHz),   // Input clock 100 MHz
        .clk_out1(clk),         // Output clock 74.25 MHz, used by the rest of the system
        .reset(1'b0),
        .locked(locked));

    button_debouncer_vect button_debouncer_mod(
        .clk(clk),.rst(rst),
        .async_buttons_in(buttons_in),
        .command_out(command));

    core_root core_root_mod(
        .clk(clk),.rst(rst),
        .command(command),
        .read_x(read_x),.read_y(read_y),
        .read_data(read_data),
        .current_color(current_color),
        .current_column(current_column),
        .current_row(current_row));

    output_root output_root_mod(
        .clk(clk),.rst(rst),
        .current_color(current_color),
        .current_column(current_column),
        .current_row(current_row),
        .read_data(read_data),
        .read_x(read_x),.read_y(read_y),
        .h_sync(h_sync),.v_sync(v_sync),
        .vgaRed(vgaRed),.vgaGreen(vgaGreen),.vgaBlue(vgaBlue));

endmodule