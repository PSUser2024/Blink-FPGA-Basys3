`timescale 1ns / 1ps
// Testbench for top: releases reset and runs long enough to observe an LED toggle at the full divide count.
module tb_top();
    logic clk = 0; //Input
    logic btnC = 1; //Input
    logic [0:0] led; //Output
    
    top #() dut (.clk(clk), .btnC(btnC), .led(led));
    
    localparam CLOCK_PERIOD = 10;
    always #(CLOCK_PERIOD / 2) clk = ~clk;
    
    initial begin
        repeat (5) @(posedge clk);
        btnC = 0;
        $display("Reset Complete");
        repeat (200000000) @(posedge clk);
        $finish;
    end
    
endmodule
