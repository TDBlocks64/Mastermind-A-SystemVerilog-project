module button_debouncer_vect(
    input logic clk, rst,

    //input logic handshake_input,
    input logic [4:0] async_buttons_in,
    output logic [4:0] command_out);

    // Commands:
    // 00000 - Nothing
    // 00001 - Go up one row
    // 00010 - Color selection one to left
    // 00100 - Confirm button
    // 01000 - Color selection one to right
    // 10000 - Go down one row



    // Buffer declaration
    logic [4:0] buff1, buff2;

    // Buffers for metastability
    always_ff @(posedge clk) begin
        if (rst) begin
            buff1 <= 5'b0;
            buff2 <= 5'b0;
        end
        else begin
            buff1 <= async_buttons_in;
            buff2 <= buff1;
        end
    end



    // Debounce declaration
    logic [16:0] counter;     // -bit counter for 1 ms at ~74.25 MHz (74250)
    logic [4:0] sync_buttons, prev_buttons;

    // Debouncer for stable signal
    always_ff @(posedge clk) begin
        if (rst) begin
            counter <= 17'b0;
            sync_buttons <= 5'b0;
            prev_buttons <= 5'b0;
        end
        else begin
            prev_buttons <= buff2;

            if (buff2 != prev_buttons) begin
                counter <= 17'b0;     // Reset counter on any change
            end
            else if (counter < 17'd74249) begin
                counter <= counter + 1'b1;
            end
            else if (sync_buttons != buff2) begin
                sync_buttons <= buff2;
            end
        end
    end



    // Pulsifier declaration
    logic [4:0] command_prev;//, command_pulse;

    // Pulsifier
    always_ff @(posedge clk) begin
        if (rst) begin
            command_prev <= 5'b00000;
        end
        else begin
            command_prev <= sync_buttons;
        end
    end

    assign command_out = sync_buttons & ~command_prev;


    /*
    // Input register
    always_ff @( posedge clk ) begin
        if (rst) begin
            command_out <= 5'b00000;
        end
        else if (handshake_input) begin
            command_out <= 5'b00000;    // Handshake -> Deletes used command
        end
        else if (command_out == 5'b00000) begin
            if (command_pulse[0]) begin
                command_out <= 5'b00001;
            end
            if (command_pulse[1]) begin
                command_out <= 5'b00010;
            end
            if (command_pulse[2]) begin
                command_out <= 5'b00100;
            end
            if (command_pulse[3]) begin
                command_out <= 5'b01000;
            end
            if (command_pulse[4]) begin
                command_out <= 5'b10000;
            end
        end
        else begin 
            command_out <= command_out; // Hold previous value
        end
    end
    */
endmodule