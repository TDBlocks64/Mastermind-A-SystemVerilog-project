module core_root(
    input logic clk, rst,

    input logic [4:0] command,

    input logic [3:0] read_x,
    input logic [2:0] read_y,

    output logic [3:0] read_data,

    //output logic handshake_input,
    
    output logic [3:0] current_color,
    output logic [3:0] current_column,
    output logic [1:0] current_row);

    logic [3:0] write_x;
    logic [1:0] write_y;
    logic [3:0] write_data;
    logic write_enable;

    state_tracker state_tracker_mod(
        .clk(clk),.rst(rst),
        .command(command),
        //.handshake_input(handshake_input),
        .write_x(write_x),.write_y(write_y),
        .write_data(write_data),
        .write_enable(write_enable),
        .current_color(current_color),
        .current_column(current_column),
        .current_row(current_row));

    grid_RAM grid_RAM_mod(
        .clk(clk),.rst(rst),
        .write_x(write_x),.write_y(write_y),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_x(read_x),.read_y(read_y),
        .read_data(read_data));

endmodule