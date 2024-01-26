module game_screen#(
    parameter WIDTH = 640,
    parameter HEIGHT = 480
)(
    input logic [9:0] x,
    input logic [9:0] y,
    input logic [9:0] p1_paddle_pos, // TODO: Reduce width
    input logic [9:0] p2_paddle_pos,
    input logic [9:0] ball_x_pos,
    input logic [9:0] ball_y_pos,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);

localparam BALL_SIZE = 2; // ball height/width

localparam PADDLE_X = 0; // paddle x-offset
localparam PADDLE_Y = 0; // paddle y-offset
localparam PADDLE_WIDTH = 4; // paddle width
localparam PADDLE_HEIGHT = 20; // paddle height

localparam PADDLE_RED = 4'hF;
localparam PADDLE_GREEN = 4'hF;
localparam PADDLE_BLUE = 4'hF;

localparam BALL_RED = 4'hF;
localparam BALL_GREEN = 4'hF;
localparam BALL_BLUE = 4'hF;

localparam BACKGROUND_RED = 4'h0;
localparam BACKGROUND_GREEN = 4'h0;
localparam BACKGROUND_BLUE = 4'h0;

logic p1_paddle_draw;
logic p2_paddle_draw;
logic ball_draw;

assign p1_paddle_draw = (x >= PADDLE_X && x <= PADDLE_X + PADDLE_WIDTH) 
                     && (y >= PADDLE_Y + p1_paddle_pos && y <= PADDLE_Y + p1_paddle_pos + PADDLE_WIDTH);

assign p2_paddle_draw = (x < WIDTH - PADDLE_X && x >= WIDTH - PADDLE_X - PADDLE_WIDTH) 
                     && (y >= PADDLE_Y + p1_paddle_pos && y <= PADDLE_Y + p1_paddle_pos + PADDLE_HEIGHT);

assign ball_draw = (x >= ball_x_pos && x < ball_x_pos + BALL_SIZE)
                && (y >= ball_y_pos && y < ball_y_pos + BALL_SIZE);

always_comb
begin
    if(p1_paddle_draw || p2_paddle_draw)
    begin
        red = PADDLE_RED;
        green = PADDLE_GREEN;
        blue = PADDLE_BLUE;
    end
    else if(ball_draw)
    begin
        red = BALL_RED;
        green = BALL_GREEN;
        blue = BALL_BLUE;
    end
    else
    begin
        red = BACKGROUND_RED;
        green = BACKGROUND_GREEN;
        blue = BACKGROUND_BLUE;
    end
end

endmodule