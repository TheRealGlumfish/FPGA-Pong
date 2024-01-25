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
    .hsync(VGA_HSYNC),
    .vsync(VGA_VSYNC),
    .red(VGA_RED),
    .green(VGA_GREEN),
    .blue(VGA_BLUE)
);

initial
begin
    reset = 0;
    repeat(500000)
    begin
	    clk = 1'b1;
	    #20 clk = 1'b0;
	    #20;
   end
end
endmodule