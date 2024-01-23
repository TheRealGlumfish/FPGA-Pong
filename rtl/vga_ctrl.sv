module vga_ctrl#(
    parameter WIDTH = 640,
    parameter HEIGHT = 480,
    parameter H_FRONT_PORCH = 12,
    parameter H_BACK_PORCH = 48,
    parameter H_SYNC = 96,
    parameter V_FRONT_PORCH = 12,
    parameter V_BACK_PORCH = 31,
    parameter V_SYNC = 2
)(
    input logic clk,
    input logic reset,
    output logic hsync,
    output logic vsync,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);

logic [9:0] vga_x; // TODO: Parametrize
logic [9:0] vga_y;

always_comb
begin
    hsync = !(vga_x > WIDTH + H_FRONT_PORCH - 1 && vga_x < WIDTH + H_FRONT_PORCH + H_SYNC - 1);
    vsync = !(vga_y > HEIGHT + V_FRONT_PORCH - 1 && vga_y < WIDTH + H_FRONT_PORCH + H_SYNC - 1);
end

always_ff@(posedge clk, posedge reset)
begin
    if(reset)
    begin
        vga_x <= 0;
        vga_y <= 0;
        red <= 8;
        green <= 8;
        blue <= 8;
    end
    else
    begin
        if(vga_x < WIDTH && vga_y < HEIGHT) // active region
        begin
            red <= 8;
            green <= 8;
            blue <= 8;
            vga_x <= vga_x + 1;
        end
        if(vga_x >= WIDTH) // horizontal sync
        begin
            red <= 0;
            //green <= vsync^hsync;
			green <= 0;
            blue <= 0;
            vga_x <= vga_x + 1;
        end
        if(vga_x >= WIDTH + H_FRONT_PORCH + H_SYNC - 1) // end of horizontal sync
        begin
            red <= 0;
            //green <= vsync^hsync;
			green <= 0;
            blue <= 0;
            vga_x <= 0;
        end
        if(vga_y >= HEIGHT) // vertical sync
        begin
            red <= 0;
            //green <= vsync^hsync;
			green <= 0;
            blue <= 0;
            vga_y <= vga_y + 1;
        end
        if(vga_y >= HEIGHT + H_FRONT_PORCH + V_SYNC - 1) // end of vertical sync
        begin
            red <= 0;
            //green <= vsync^hsync;
			green <= 0;
            vga_y <= 0;
        end
    end
end



endmodule