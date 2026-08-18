`timescale 1ns / 1ps
// Testbench for top: releases reset and runs long enough to observe an LED toggle at the full divide count.
module tb_top();
    logic clk = 0; //Input
    logic btnC = 1; //Input
    logic [0:0] led; //Output
    
    localparam CLOCK_PERIOD_NS = 10;
    localparam CLK_HZ = 1e9 / CLOCK_PERIOD_NS;
    
    top #(.CLK_HZ(CLK_HZ), .BLINK_HZ(1e6)) dut (.clk(clk), .btnC(btnC), .led(led));

    always #(CLOCK_PERIOD_NS / 2) clk = ~clk;
    
    initial begin
        repeat (5) @(posedge clk);
        btnC = 0;
        $display("Initial Reset");
        repeat (150) @(posedge clk);
        btnC = 1;
        repeat (20) @(posedge clk);
        btnC = 0;
        $display("Reset Complete");
        repeat (100) @(posedge clk);
        $finish;
    end
    
endmodule
