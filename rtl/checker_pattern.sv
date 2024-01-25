module checker_pattern#(
    parameter RED = 4'b1111,
    parameter GREEN = 4'b1111,
    parameter BLUE = 4'b1111,  
    parameter DARK_RED = 4'b0000,
    parameter DARK_BLUE = 4'b0000,
    parameter DARK_GREEN = 4'b0000
)(
    input logic [9:0] x,
    input logic [9:0] y,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);

logic dark;

assign dark = x % 4 || y % 4;

assign red = dark ? RED : DARK_RED;
assign green = dark ? GREEN : DARK_GREEN;
assign blue = dark ? BLUE : DARK_BLUE;

endmodule