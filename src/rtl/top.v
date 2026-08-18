`timescale 1ns / 1ps
// Top level: blinks led at ~1 Hz on a Basys3, with btnC as active-low reset.


module top #(
    parameter int CLK_HZ = 100_000_000,
    parameter int BLINK_HZ = 2
)(
    input logic clk,
    input logic btnC,
    output logic [0:0] led
);

    localparam int DIVIDE = CLK_HZ / (2*BLINK_HZ);
    
    logic enable;
    logic nrst;
    
    assign nrst = ~btnC;
    
    enable_gen #(.DIVIDE(DIVIDE)) enable_gen0 (.clk(clk), .nrst(nrst), .enable(enable));
    
    led_blink #() led_blink0 (.clk(clk), .nrst(nrst), .enable(enable), .led(led));

endmodule
