module vga_ctrl#(
    parameter WIDTH = 640,
    parameter HEIGHT = 480,
    parameter H_FRONT_PORCH = 12,
    parameter H_BACK_PORCH = 48,
    parameter H_SYNC = 96,
    parameter V_FRONT_PORCH = 10,
    parameter V_BACK_PORCH = 33,
    parameter V_SYNC = 2
)(
    input logic clk,
    input logic reset,
    output logic [9:0] x, // TODO: Parametrize
    output logic [9:0] y,
    input logic [3:0] red,
    input logic [3:0] green,
    input logic [3:0] blue,
    output logic hsync,
    output logic vsync,
    output logic [3:0] vga_red,
    output logic [3:0] vga_green,
    output logic [3:0] vga_blue
);

typedef enum {ACTIVE, FRONT_PORCH, SYNC, BACK_PORCH} VGA_STATE;

VGA_STATE h_state;
VGA_STATE v_state;

initial
begin
    h_state = ACTIVE;
    v_state = ACTIVE;
    x = 0;
    y = 0;
end

always_ff@(posedge clk, posedge reset)
begin
    if(reset)
    begin
        h_state <= ACTIVE;
        v_state <= ACTIVE;
        x = 0;
        y = 0;
    end
    else
    begin
        case(h_state)
            ACTIVE:
            if(x < WIDTH - 1)
            begin
                h_state <= ACTIVE;
                x <= x + 1;
            end
            else
            begin
                h_state <= FRONT_PORCH; 
                x <= 0;
                y <= y + 1; // potentially change
            end
            FRONT_PORCH:
            if(x < H_FRONT_PORCH - 1)
            begin
                h_state <= FRONT_PORCH;
                x <= x + 1;
            end
            else
            begin
                h_state <= SYNC;
                x <= 0;
            end
            SYNC:
            if(x <= H_SYNC - 1)
            begin
                h_state <= SYNC;
                x <= x + 1;
            end
            else
            begin
                h_state <= BACK_PORCH;
                x <= 0;
            end
            BACK_PORCH:
            if(x <= H_BACK_PORCH - 1)
            begin
                h_state <= BACK_PORCH;
                x <= x + 1;
            end
            else
            begin
                h_state <= ACTIVE;
                x <= 0;
            end
        endcase
        case(v_state)
            ACTIVE:
            if(y <= HEIGHT - 1)
                v_state <= ACTIVE;
            else
            begin
                v_state <= FRONT_PORCH;
                y <= 0;
            end
            FRONT_PORCH:
            if(y <= V_FRONT_PORCH - 1)
                v_state <= FRONT_PORCH;
            else
            begin
                v_state <= SYNC;
                y <= 0;
            end
            SYNC:
            if(y <= V_SYNC - 1)
                v_state <= SYNC;
            else
            begin
                v_state <= BACK_PORCH;
                y <= 0;
            end
            BACK_PORCH:
            if(y <= V_BACK_PORCH - 1)
                v_state <= BACK_PORCH;
            else
            begin
                v_state <= ACTIVE;
                y <= 0;
            end
        endcase
    end
end

always_comb
begin     
    vga_red = (h_state == ACTIVE && v_state == ACTIVE) ? red : 4'b0000;
    vga_green = (h_state == ACTIVE && v_state == ACTIVE) ? green : 4'b0000; // implement sync pulse on green
    vga_blue = (h_state == ACTIVE && v_state == ACTIVE) ? blue : 4'b0000;
    hsync = (h_state == SYNC) ? 1'b0 : 1'b1;
    vsync = (v_state == SYNC) ? 1'b0 : 1'b1;
end

endmodule