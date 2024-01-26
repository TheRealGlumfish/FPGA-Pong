`timescale 1ns/1ns
module counter_tb;

logic clk;
logic [31:0] counter;
logic trigger;

counter #(100) DUT(
    .clk(clk),
    .count(counter),
    .trigger(trigger)
);

initial
begin
    repeat(5000)
    begin
        clk = 1'b1;
        #20 clk = 1'b0;
        #20;
    end
end

endmodule