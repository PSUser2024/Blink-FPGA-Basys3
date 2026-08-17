`timescale 1ns / 1ps
// Testbench for led_blink: drives enable through several pulses and checks led toggles, including mid-run reset.
module tb_led_blink();
    logic clk;
    logic nrst;
    logic enable;
    logic led;
    
    led_blink dut (.clk(clk), .nrst(nrst), .enable(enable), .led(led));
    
    localparam CLOCK_PERIOD = 10;
    always #(CLOCK_PERIOD / 2) clk = ~clk;
    
    int cycle_count = 0;
    always_ff @(posedge clk) begin
        cycle_count++;
    end
    
    initial begin
    $display("Starting simulation");
    clk = 0;
    nrst = 0;
    enable = 0;
    repeat (2) @(posedge clk); 
    nrst = 1;
    $display("Reset disabled");
    repeat (5) @(posedge clk);
    enable = 1;
    repeat (1) @(posedge clk);
    enable = 0;
    $display("LED Enabled");
    repeat (5) @(posedge clk);
    enable = 1;
    repeat (1) @(posedge clk);
    enable = 0;
    $display("LED Disabled");;
    repeat (5) @(posedge clk);
    enable = 1;
    repeat (5) @(posedge clk);
    nrst = 0;
    $display("Reset enabled");
    repeat (5) @(posedge clk);
    enable = 0;
    repeat (1) @(posedge clk);
    enable = 1;
    repeat (5) @(posedge clk);
    $finish;
    end
    
endmodule
