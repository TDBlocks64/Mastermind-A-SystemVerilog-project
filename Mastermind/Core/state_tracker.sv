

/*
State tracker module that keeps track of various variables of the game.
*/


module state_tracker(
    input logic clk, rst,

    input logic [4:0] command,

    output logic [3:0] write_x,
    output logic [1:0] write_y,
    output logic [3:0] write_data,
    output logic write_enable,

    output logic [3:0] current_color,
    output logic [3:0] current_column,
    output logic [1:0] current_row);

    // Color selection logic
    always_ff @(posedge clk) begin
        if (rst) begin
            current_color <= 4'b0000;
        end
        else begin
            if ((current_color > 4'b0000) && (command == 5'b00010)) begin
                current_color <= current_color - 1'b1;
            end
            else if ((current_color < 4'b1001) && (command == 5'b01000)) begin
                current_color <= current_color + 1'b1;
            end
            else begin
                current_color <= current_color;
            end
        end
    end

    // Row selection logic
    always_ff @(posedge clk) begin
        if (rst) begin
            current_row <= 2'b00;
        end
        else begin
            if ((current_row > 2'b00) && (command == 5'b00001)) begin
                current_row <= current_row - 1'b1;
            end
            else if ((current_row < 2'b11) && (command == 5'b10000)) begin
                current_row <= current_row + 1'b1;
            end
            else begin
                current_row <= current_row;
            end
        end
    end

    // Color placing and solution confirmation logic
    always_ff @(posedge clk) begin
        if (rst) begin
            current_column <= 4'b0000;
            write_x <= 4'b0000;
            write_y <= 2'b00;
            write_data <= 4'b0000;
            write_enable <= 1'b0;
        end
        else begin
            if ((current_color < 4'b1001) && (command == 5'b00100)) begin
                write_x <= current_column;
                write_y <= current_row;
                write_data <= current_color;
                write_enable <= 1'b1;
            end
            else if ((current_color == 4'b1001) && (command == 5'b00100) && (current_column < 4'b1001)) begin
                current_column <= current_column + 1'b1;
            end
            else begin
                current_column <= current_column;
                write_x <= write_x;
                write_y <= write_y;
                write_data <= 4'b0000;
                write_enable <= 1'b0;
            end
        end
    end
endmodule