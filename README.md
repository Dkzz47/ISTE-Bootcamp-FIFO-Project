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
