`timescale 1ns/1ns
module vga_tb;

logic clk;
logic reset;
logic [9:0] VGA_X;
logic [9:0] VGA_Y;
logic VGA_HSYNC;
logic VGA_VSYNC;
logic [3:0] VGA_RED;
logic [3:0] VGA_GREEN;
logic [3:0] VGA_BLUE;

vga_ctrl DUT(
    .clk(clk),
    .reset(reset),
    .x(VGA_X),
    .y(VGA_Y),
    .red(4'b1111),
    .green(4'b1111),
    .blue(4'b1111),
    .hsync(VGA_HSYNC),
    .vsync(VGA_VSYNC),
    .vga_red(VGA_RED),
    .vga_green(VGA_GREEN),
    .vga_blue(VGA_BLUE)
);

initial
begin
    reset = 1'b1;
    #20 reset = 0'b0;
end

initial
begin
    repeat(500000)
    begin
	    clk = 1'b1;
	    #20 clk = 1'b0;
	    #20;
   end
end
endmodule