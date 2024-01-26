module counter#(
    parameter MAX = 1000000
)(
    input logic clk,
    output logic [31:0] count,
    output logic trigger
);

initial
begin
    count = 0;
    trigger = 0;
end

always_ff@(posedge clk)
begin
    if(count < MAX - 1)
    begin
        count <= count + 1;
        trigger <= 0;
    end
    else
    begin
        count <= 0;
        trigger <= 1;
    end
end

endmodule