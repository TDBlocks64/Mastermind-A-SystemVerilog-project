

/*
RAM module that keeps track of the colors in the grid.
Features a synchronous write channel and an asynchronous read channel.
*/


module grid_RAM(
    input logic clk, rst,

    input logic [3:0] write_x,      // X coordinate for RAM writing
    input logic [1:0] write_y,      // Y coordinate for RAM writing
    input logic [3:0] write_data,   // Write data
    input logic write_enable,
                    
    input logic [3:0] read_x,       // X coordinate for RAM reading
    input logic [2:0] read_y,       // Y coordinate for RAM reading

    output logic [3:0] read_data);  // Read data

    // Memory declaration
    logic [3:0] mem [9:0][3:0];     // 4 bits per entry, 10 x-coordinates and 4 y-coordinates

    // Initializition & writing
    always_ff @ (posedge clk) begin : ram_ff    // Updates the stored data synchronously if enabled
        if (rst) begin
            for (int i = 0; i < 10; i++) begin
                for (int j = 0; j < 4; j++) begin
                    mem[i][j] <= 4'b0000;      // Reset the grid
                end
            end
        end
        else begin
            if (write_enable) begin
                mem[write_x][write_y] <= write_data;     // Synchronous write
            end
        end
    end

    // Reading
    assign read_data = ((read_x < 10) && (read_y < 4)) ? mem[read_x][read_y] : 4'b0000;    // Asynchronous data read

endmodule