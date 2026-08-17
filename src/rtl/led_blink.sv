`timescale 1ns / 1ps
// Toggles led each time enable rises, producing a visible blink from the enable pulse train.


module led_blink(
    input logic clk,
    input logic nrst,
    input logic enable,
    output logic led
);
    
    logic prev_state;
    
    always_ff @(posedge clk) begin
        if (!nrst) begin
            led <= 1'b0;
            prev_state <= 1'b0;
        end else begin
            prev_state <= enable;
            if (enable & ~prev_state) begin
                led <= ~led;
            end
        end
    end            
        
endmodule
