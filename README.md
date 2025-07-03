# ISTE-Bootcamp-FIFO-Project
This repository contains a clean and modular implementation of an Asynchronous FIFO buffer designed in Verilog HDL. The FIFO is designed to support independent clock domains for reading and writing, making it ideal for clock domain crossing (CDC) scenarios in digital systems. It was developed as part of the ISTE Bootcamp initiative to help students and enthusiasts understand reliable CDC design practices.
# Features
* Dual clock domain FIFO with separate wclk and rclk
* 2-flip-flop synchronizers for reliable CDC
* Gray code pointers to avoid glitches
* Dual-port RAM with simultaneous read and write access
* FULL and EMPTY flag generation using MSB-inverted comparison
* Parameterized address and data widths
* Fully testbench-verified with edge-case coverage
# Design Overview
The FIFO uses separate read and write clocks, making it suitable for asynchronous systems such as inter-processor bridges, streaming interfaces, or SoC modules. Each side of the FIFO maintains its own pointer (read and write) in Gray code, which is then synchronized into the opposite clock domain using two-stage flip-flop synchronizers. The FULL condition is determined by checking if the next Gray-coded write pointer matches the synchronized version of the read pointer with MSB inversion. The EMPTY condition is similarly detected when the Gray-coded read pointer equals the synchronized write pointer. A dual-port RAM is used to allow concurrent read and write operations from different clock domains. Parameterization allows you to easily scale the FIFO to different data widths and depths.
# Module Descriptions
[top_fifo.v](Assignment3/top_fifo.v) : Top-level wrapper module that integrates all submodules to form a complete asynchronous FIFO. It connects the write and read pointer logic, dual-port memory, and synchronizers. It handles control signals like winc, rinc, wfull, and rempty.

[FIFO_Memory.v](Assignment3/FIFO_Memory.v) : Implements the dual-port RAM used for data storage. It allows simultaneous write and read operations using separate clocks. This module is purely combinational on the read side and synchronous on the write side.

[wptr_full.v](Assignment3/wptr_full.v) : Manages the write pointer logic and generates the FIFO full (wfull) flag. The pointer is maintained in both binary and Gray code formats. It also synchronizes the read pointer into the write clock domain using a 2-flip-flop synchronizer for full detection.

[rptr_empty.v](Assignment3/rptr_empty.v) : Handles the read pointer logic and produces the FIFO empty (rempty) flag. Like the write side, it maintains both binary and Gray versions of the read pointer and synchronizes the write pointer into the read domain.

[ff_sync.v](Assignment3/ff_sync.v) : A generic 2-stage flip-flop synchronizer used to safely pass multi-bit signals (specifically pointers) across asynchronous clock domains. It helps mitigate metastability issues that arise during clock domain crossing.

[FIFO_tb.v](Assignment3/FIFO_tb.v) : The testbench that simulates the complete FIFO design. It provides independent wclk and rclk, drives winc and rinc for write/read operations, and verifies conditions like FIFO full, empty, overflow, and underflow. It ensures functional correctness across various timing and edge scenarios.
