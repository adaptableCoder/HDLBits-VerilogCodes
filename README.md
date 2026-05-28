# HDLBits Verilog Solutions

## About

This repository contains my personal Verilog solutions for the HDLBits platform. The folder structure mirrors the HDLBits problem set hierarchy; each Verilog file is a focused solution to a specific HDLBits exercise. The collection is intended as a portfolio demonstrating proficiency in RTL design, combinational and sequential logic.

Key points:

- Educational and portfolio-focused solutions, organized to mirror HDLBits categories.
- Files are intended as reference implementations and learning artifacts (not drop-in assignments for coursework).

## Repository structure

The workspace is organized to match HDLBits problem sections. The tree below reflects the current repository contents:

```
HDLBits-Verilog-Codes/
├── (1) Getting Started/
│   ├── Getting_Started.v
│   └── Output_Zero.v
├── (2) Verilog Language/
│   ├── (2.1) Basics/
│   │   ├── 7458_chip.v
│   │   ├── AND_gate.v
│   │   ├── Declaring_wires.v
│   │   ├── Four_wires.v
│   │   ├── Inverter.v
│   │   ├── NOR_gate.v
│   │   ├── Simple_wire.v
│   │   └── XNOR_gate.v
│   ├── (2.2) Vectors/
│   │   ├── Bitwise_operators.v
│   │   ├── Fourinput_gates.v
│   │   ├── More_replication.v
│   │   ├── Replication_operator.v
│   │   ├── Vector_concatenation_operator.v
│   │   ├── Vector_part_select.v
│   │   ├── Vector_reversal_1.v
│   │   ├── Vectors_in_more_detail.v
│   │   └── Vectors.v
│   ├── (2.3) Modules - Hierarchy/
│   │   ├── Adder_1.v
│   │   ├── Adder_2.v
│   │   ├── Addersubtractor.v
│   │   ├── Carryselect_adder.v
│   │   ├── Connecting_ports_by_name.v
│   │   ├── Connecting_ports_by_position.v
│   │   ├── Modules_and_vectors.v
│   │   ├── Modules.v
│   │   └── Three_modules.v
│   ├── (2.4) Procedures/
│   │   ├── Always_blocks_clocked.v
│   │   ├── Always_blocks_combinational.v
│   │   ├── Avoiding_latches.v
│   │   ├── Case_statement.v
│   │   ├── If_statement_latches.v
│   │   ├── If_statement.v
│   │   ├── Priority_encoder_with_casez.v
│   │   └── Priority_encoder.v
│   └── (2.5) More Verilog Features/
│       ├── Combinational_forloop_255bit_population_count.v
│       ├── Combinational_forloop_Vector_reversal_2.v
│       ├── Conditional_ternary_operator.v
│       ├── Generate_forloop_100bit_binary_adder_2.v
│       ├── Generate_forloop_100digit_BCD_adder.v
│       ├── Reduction_Even_wider_gates.v
│       └── Reduction_operators.v
├── (3) Circuits/
│   ├── (3.1) Combinational Logic/
│   │   ├── (3.1.1) Basic Gates/
│   │   ├── (3.1.2) Multiplexers/
│   │   └── (3.1.3) Arithmetic Circuits/
│   ├── (3.2) Sequential Logic/
│   │   ├── (3.2.1) Latches and Flip-Flops/
│   │   ├── (3.2.2) Counters/
│   │   ├── (3.2.3) Shift Registers/
│   │   └── (3.2.4) More Circuits/
│   └── (3.3) Building Larger Circuits/
│       ├── 4bit_shift_register_and_down_counter.v
│       ├── Counter_with_period_1000.v
│       ├── FSM_Enable_shift_register.v
│       ├── FSM_Onehot_logic_equations.v
│       ├── FSM_Sequence_1101_recognizer.v
│       ├── FSM_The_complete_FSM.v
│       └── The_complete_timer.v
├── (4) Verification - Reading Simulations/
│   ├── (4.1) Finding bugs in code/
│   └── (4.2) Build a circuit from a simulation waveform/
├── (5) Verification - Writing Testbenches/
│   ├── AND_gate.v
│   ├── Clock.v
│   ├── T_flipflop.v
│   ├── Testbench1.v
│   └── Testbench2.v
└── (6) CS450/
    ├── counter_2bc.v
    ├── gshare.v
    ├── history_shift.v
    └── timer.v
```

> Note: filenames reflect the original HDLBits exercise names or a short descriptive name.

## Academic integrity disclaimer

These solutions are provided for reference and personal portfolio purposes. If you are currently taking a course that uses HDLBits, please adhere to your university's academic integrity guidelines and do not copy these solutions.

## License

This repository is distributed under the MIT License. See the `LICENSE` file for details.