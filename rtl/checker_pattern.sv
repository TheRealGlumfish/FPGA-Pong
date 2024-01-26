module checker_pattern#(
    parameter RED = 4'hF,
    parameter GREEN = 4'hF,
    parameter BLUE = 4'hF,  
    parameter DARK_RED = 4'h0,
    parameter DARK_BLUE = 4'h0,
    parameter DARK_GREEN = 4'h0
)(
    input logic [9:0] x,
    input logic [9:0] y,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);

logic dark;

assign dark = x % 4 || y % 4;

assign red = dark ? DARK_RED : RED;
assign green = dark ? DARK_GREEN : GREEN;
assign blue = dark ? DARK_BLUE : BLUE;

endmodule