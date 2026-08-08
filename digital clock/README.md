# Digital Clock Using Verilog HDL

A simple **24-hour digital clock implemented using Verilog HDL**. The project demonstrates clock division, seconds/minutes/hours counters, reset functionality, simulation, and waveform generation.

## Features

* 24-hour digital clock
* Displays time in `HH:MM:SS` format
* Seconds counter: `00–59`
* Minutes counter: `00–59`
* Hours counter: `00–23`
* Automatic rollover from `23:59:59` to `00:00:00`
* Synchronous clock counting with reset
* Parameterized clock frequency
* Verilog testbench included
* VCD waveform generation for GTKWave
* Suitable for FPGA/HDL learning

## Project Structure

```text
digital-clock-verilog/
│
├── src/
│   └── digital_clock.v
│
├── tb/
│   └── digital_clock_tb.v
│
├── simulation/
│   └── simulation_output.txt
│
├── waveform/
│   └── digital_clock.vcd
│
└── README.md
```

## Working Principle

The digital clock receives a clock signal from the FPGA or simulation environment.

The input clock is divided into a one-second enable pulse. The counters then operate as follows:

```text
Clock
  │
  ▼
Clock Divider
  │
  ▼
Seconds Counter
  │
  ├── 00 → 59
  │
  ▼
Minutes Counter
  │
  ├── 00 → 59
  │
  ▼
Hours Counter
  │
  └── 00 → 23
```

When the seconds counter reaches `59`, it resets to `00` and increments the minutes counter.

When the minutes counter reaches `59`, it resets to `00` and increments the hours counter.

When the clock reaches `23:59:59`, the next second changes the time to:

```text
00:00:00
```

## Module Interface

| Signal    | Direction | Description       |
| --------- | --------- | ----------------- |
| `clk`     | Input     | System clock      |
| `reset`   | Input     | Active-high reset |
| `hours`   | Output    | Hours, 0–23       |
| `minutes` | Output    | Minutes, 0–59     |
| `seconds` | Output    | Seconds, 0–59     |

## Parameter

The module contains a configurable clock-frequency parameter:

```verilog
parameter integer CLOCK_FREQ = 10
```

For simulation, `CLOCK_FREQ = 10` is used to make the simulation faster.

For a real FPGA board, change the value to match the board's oscillator frequency.

For example, with a 50 MHz clock:

```verilog
digital_clock #(
    .CLOCK_FREQ(50000000)
) uut (
    .clk(clk),
    .reset(reset),
    .hours(hours),
    .minutes(minutes),
    .seconds(seconds)
);
```

For a 100 MHz FPGA clock:

```verilog
.CLOCK_FREQ(100000000)
```

## Simulation

The project can be simulated using:

* Icarus Verilog
* GTKWave
* ModelSim
* QuestaSim
* Vivado Simulator

### Using Icarus Verilog

Compile the design and testbench:

```bash
iverilog -o digital_clock_sim src/digital_clock.v tb/digital_clock_tb.v
```

Run the simulation:

```bash
vvp digital_clock_sim
```

The terminal will display the clock values.

Example:

```text
Digital Clock = 00:00:00
Digital Clock = 00:00:01
Digital Clock = 00:00:02
Digital Clock = 00:00:03
Digital Clock = 00:00:04
Digital Clock = 00:00:05
...
Digital Clock = 00:00:11
```

## Viewing Waveforms

The testbench generates:

```text
digital_clock.vcd
```

Open it using GTKWave:

```bash
gtkwave digital_clock.vcd
```

Add the following signals to the waveform:

```text
clk
reset
hours
minutes
seconds
```

You can observe the seconds counter incrementing and the rollover behavior of the minutes and hours counters.

## Example

The clock starts at:

```text
00:00:00
```

After one second:

```text
00:00:01
```

After 60 seconds:

```text
00:01:00
```

After one hour:

```text
01:00:00
```

At the end of the day:

```text
23:59:59
```

The next second:

```text
00:00:00
```

## FPGA Implementation

For FPGA implementation, connect the `clk` input to the board's oscillator.

For example, if the FPGA has a 50 MHz oscillator:

```verilog
digital_clock #(
    .CLOCK_FREQ(50000000)
) clock_inst (
    .clk(clk_50mhz),
    .reset(reset),
    .hours(hours),
    .minutes(minutes),
    .seconds(seconds)
);
```

The `hours`, `minutes`, and `seconds` outputs can then be connected to:

* Seven-segment displays
* LEDs
* LCD
* OLED
* UART interface
* FPGA development board display

## Future Improvements

Possible extensions to this project include:

* Seven-segment display driver
* Alarm clock functionality
* Set-hours/set-minutes buttons
* AM/PM 12-hour mode
* Stopwatch
* Countdown timer
* Debouncing for push buttons
* FPGA board-specific constraints
* LCD/OLED display interface
* BCD output for seven-segment displays

## Learning Objectives

This project is useful for learning:

* Verilog HDL
* Sequential logic
* Counters
* Clock division
* Parameters
* Reset logic
* Testbench development
* Simulation
* Waveform analysis
* FPGA design concepts

## License

This project is provided for educational and personal use.

## Author

**Digital Clock using Verilog HDL**

If you find this project useful, consider giving the repository a ⭐ on GitHub.
