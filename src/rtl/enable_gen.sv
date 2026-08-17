`timescale 1ns / 1ps
// Generates a single-cycle enable pulse every DIVIDE clock cycles.


module enable_gen #(parameter DIVIDE = 5) (
    input logic clk,
    input logic nrst,
    output logic enable
    );
    
    logic [$clog2(DIVIDE)-1:0] counter;
    
    always_ff @(posedge clk or negedge nrst) begin
        if (!nrst) begin 
            enable <= 1'b0;
            counter <= '0;
        end else begin
            if (counter == DIVIDE - 1) begin
                counter <= '0;
                enable <= 1'b1;
            end else begin
                counter <= counter + 1;
                enable <= 1'b0;
            end     
        end 
    end
    
endmodule
