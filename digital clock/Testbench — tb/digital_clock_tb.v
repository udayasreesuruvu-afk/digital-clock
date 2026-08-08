`timescale 1ns/1ps

module digital_clock_tb;

    // Testbench clock
    reg clk;
    reg reset;

    // Clock outputs
    wire [4:0] hours;
    wire [5:0] minutes;
    wire [5:0] seconds;

    // Instantiate Digital Clock
    digital_clock #(
        .CLOCK_FREQ(10)
    ) uut (
        .clk(clk),
        .reset(reset),
        .hours(hours),
        .minutes(minutes),
        .seconds(seconds)
    );

    // Generate clock
    // Clock period = 10 ns
    always #5 clk = ~clk;

    // Display clock value
    always @(posedge clk) begin
        $display(
            "Simulation Time = %0t ns | Digital Clock = %02d:%02d:%02d",
            $time,
            hours,
            minutes,
            seconds
        );
    end

    // Test sequence
    initial begin

        // Create VCD waveform
        $dumpfile("digital_clock.vcd");
        $dumpvars(0, digital_clock_tb);

        // Initial values
        clk   = 0;
        reset = 1;

        // Apply reset
        #20;
        reset = 0;

        // Run simulation
        #1250;

        $display("-----------------------------------------");
        $display("Simulation completed successfully.");
        $display("-----------------------------------------");

        $finish;
    end

endmodule