`timescale 1ns / 1ps
// Testbench for enable_gen: asserts an enable pulse fires every DIVIDE cycles.
module tb_enable_gen();

    logic clk = 0;
    logic nrst;
    logic enable;
    
    parameter int DIVIDE = 4;
    
    enable_gen #(.DIVIDE(DIVIDE)) dut(.clk(clk), .nrst(nrst), .enable(enable));
    
    //Avoid magic variables
    localparam CLOCK_PERIOD = 10;
    
    //Initialize clock
    always #(CLOCK_PERIOD / 2) clk = ~clk;
    
    int cycle_count = 0;

    always_ff @(posedge clk) begin
        cycle_count++;
    end
    
    property en_correct_timing;
        @(posedge clk)
        disable iff (!nrst)
        (cycle_count % DIVIDE == 0) |-> enable;
    endproperty 
    
    assert property (en_correct_timing)
        else $error("Enable high at incorrect cycle %0d", cycle_count);
    
    
    initial begin
        nrst = 0;
        $display("Starting simulation");
        #10; nrst = 1;
        $display("Reset disabled");
        repeat (DIVIDE * 5) @(posedge clk);
        nrst = 0;
        $display("Reset enabled");
        #10;
        $finish;
    end
endmodule
