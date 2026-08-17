`timescale 1ns / 1ps
// Top level: blinks led at ~1 Hz on a Basys3, with btnC as active-low reset.


module top(
    input logic clk,
    input logic btnC,
    output logic [0:0] led
);

logic enable;
logic nrst;

assign nrst = ~btnC;

enable_gen #(.DIVIDE(50000000)) enable_gen0 (.clk(clk), .nrst(nrst), .enable(enable));

led_blink #() led_blink0 (.clk(clk), .nrst(nrst), .enable(enable), .led(led));

endmodule
