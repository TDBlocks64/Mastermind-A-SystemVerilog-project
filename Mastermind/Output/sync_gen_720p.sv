

/*
VGA sync generator module for 1280 x 720 @ 60 Hz.
Uses ~74.25 MHz as clock frequency.
Provides counter framework.
Produces h_sync and v_sync signals for the monitor.
Produces visible signal, color signals should be zero when not in the visible part of the screen.
Produces handshake signal to tell other modules when not writing to the visible part of the screen.
*/


module sync_gen_720p(
    input logic clk, rst,
    
    output logic [10:0] h_count,
    output logic [9:0] v_count,
    output logic h_sync, v_sync, 
    output logic visible, 
    output logic handshake_output);

    logic [10:0] h_count_next;
    logic [9:0] v_count_next;

    typedef enum logic [1:0] {H_VISIBLE, H_FRONT, H_SYNC, H_BACK} h_state_t;
    h_state_t h_state, h_state_next;

    typedef enum logic [1:0] {V_VISIBLE, V_FRONT, V_SYNC, V_BACK} v_state_t;
    v_state_t v_state, v_state_next;

    always_ff @(posedge clk) begin
        if (rst) begin
            h_state <= H_VISIBLE;
            v_state <= V_VISIBLE;
            h_count <= 11'b0;
            v_count <= 10'b0;
        end else begin
            h_state <= h_state_next;
            v_state <= v_state_next;
            h_count <= h_count_next;
            v_count <= v_count_next;
        end
    end

    always_comb begin
        h_state_next = h_state;
        h_count_next = h_count;
        v_state_next = v_state;
        v_count_next = v_count;
        case (h_state)
            H_VISIBLE: begin
                if (h_count == 1279) begin
                    h_state_next = H_FRONT;
                    h_count_next = h_count + 1;
                end else begin
                    h_count_next = h_count + 1;
                end
            end
            H_FRONT: begin
                if (h_count == 1389) begin
                    h_state_next = H_SYNC;
                    h_count_next = h_count +1;
                end else begin
                    h_count_next = h_count + 1;
                end
            end
            H_SYNC: begin
                if (h_count == 1429) begin
                    h_state_next = H_BACK;
                    h_count_next = h_count + 1;
                end else begin
                    h_count_next = h_count + 1;
                end
            end
            H_BACK: begin
                if (h_count == 1649) begin
                    h_count_next = 0;
                    h_state_next = H_VISIBLE;
                    v_count_next = v_count + 1;
                end else h_count_next = h_count + 1;
            end
            default: begin
                h_state_next = H_VISIBLE;
                h_count_next = 0;
            end
        endcase
        case (v_state)
            V_VISIBLE: begin
                if (v_count == 719) v_state_next = V_FRONT;
                else v_state_next = V_VISIBLE;
            end
            V_FRONT: begin
                if (v_count == 724) v_state_next = V_SYNC;
                else v_state_next = V_FRONT;
            end
            V_SYNC: begin
                if (v_count == 729) v_state_next = V_BACK;
                else v_state_next = V_SYNC;
            end
            V_BACK: begin
                if (v_count == 749) begin
                    v_count_next = 0;
                    v_state_next = V_VISIBLE;
                end else v_state_next = V_BACK;
            end
            default: begin
                v_state_next = V_VISIBLE;
                v_count_next = 0;
            end
        endcase
    end

    always_comb begin
        h_sync = (h_state == H_SYNC) ? 1'b0 : 1'b1;
        v_sync = (v_state == V_SYNC) ? 1'b0 : 1'b1;

        visible = (h_state == H_VISIBLE) && (v_state == V_VISIBLE);

        handshake_output = (v_state != V_VISIBLE) ? 1'b1 : 1'b0; // Results in 49.5k clock cycles of time before next frame
    end

endmodule