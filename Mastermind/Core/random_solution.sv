module random_solution(
    input logic clk, rst,
    
    input logic [4:0] command,

    output logic [3:0] rnd_col_1, rnd_col_2, rnd_col_3, rnd_col_4);

    logic [15:0] rnd_number;
    logic [3:0] rnd_col_1_prev, rnd_col_2_prev, rnd_col_3_prev, rnd_col_4_prev;

    logic feedback;
    logic first_capture, first_capture_prev, first_capture_pulse;



    // LFSR
    assign feedback = rnd_number[15] ^ rnd_number[13] ^ rnd_number[12] ^ rnd_number[10];

    always_ff @(posedge clk) begin
        if (rst) begin
            rnd_number <= 16'hB4C3;     // Non-zero starting seed
        end
        else begin
            rnd_number <= {rnd_number[14:0], feedback};     // Adding feedback to pseudo randomize
        end
    end



    // First capture logic to only capture one randomised solution
    always_ff @(posedge clk) begin
        if (rst) begin
            first_capture <= 1'b0;
        end
        else if ((first_capture == 1'b0) && (command == 5'b00100)) begin
            first_capture <= 1'b1;
        end
    end

    // Pulsifier to only receive one first capture pulse
    always_ff @(posedge clk) begin
        if (rst) begin
            first_capture_prev <= 1'b0;
        end
        else begin
            first_capture_prev <= first_capture;
        end
    end

    assign first_capture_pulse = first_capture & ~first_capture_prev;



    // Splitting the 16-bit random number to 4x 3-bit numbers
    assign rnd_col_1_prev = {rnd_number[0], rnd_number[5], rnd_number[10]} + 1;
    assign rnd_col_2_prev = {rnd_number[1], rnd_number[6], rnd_number[11]} + 1;
    assign rnd_col_3_prev = {rnd_number[2], rnd_number[7], rnd_number[12]} + 1;
    assign rnd_col_4_prev = {rnd_number[3], rnd_number[8], rnd_number[13]} + 1;



    // Capturing the random values
    always_ff @(posedge clk) begin
        if (rst) begin
            rnd_col_1 <= 4'b0000;
        end
        else if (first_capture_pulse == 1'b1) begin     // Capture the values when confirming for the first time
            rnd_col_1 <= rnd_col_1_prev;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            rnd_col_2 <= 4'b0000;
        end
        else if (first_capture_pulse == 1'b1) begin     // Capture the values when confirming for the first time
            rnd_col_2 <= rnd_col_2_prev;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            rnd_col_3 <= 4'b0000;
        end
        else if (first_capture_pulse == 1'b1) begin     // Capture the values when confirming for the first time
            rnd_col_3 <= rnd_col_3_prev;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            rnd_col_4 <= 4'b0000;
        end
        else if (first_capture_pulse == 1'b1) begin     // Capture the values when confirming for the first time
            rnd_col_4 <= rnd_col_4_prev;
        end
    end
endmodule