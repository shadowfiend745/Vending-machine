# 🪙 FPGA Vending Machine Controller — VHDL

A hardware-implemented vending machine controller built in VHDL and deployed on a **Xilinx Artix-7 FPGA** using Xilinx Vivado. The system uses a **Moore Finite State Machine (FSM)** with 24 distinct states to manage coin input, transaction logic, item dispensing, and change return — all with real-time 7-segment display feedback.

---

## 📌 Features

- **24-state Moore FSM** handling multi-step transaction flows
- Accepts **$0.25, $1.00, and $2.00** coin inputs
- **Cancel / Confirm** transaction controls
- Automatic **change return** for 7 denomination combinations ($0.25 → $1.75)
- Real-time **8-digit 7-segment display** showing current credit balance
- Hardware **debouncing** on all coin inputs to eliminate switch noise
- Synchronous reset and clock-edge triggered state registers

---

## 🗂️ File Structure

```
├── MAIN_CODE.vhd               # Top-level FSM entity (UpgradedVending_final)
├── segment_display_bdong.vhd   # BCD to 7-segment decoder component
├── EIGHT_TO_ONE_BD.vhd         # 8-to-1 display multiplexer component
├── Debounce_bdong.vhd          # Switch debounce component
├── D_ff_bdong.vhd              # D flip-flop component
```

---

## ⚙️ System Architecture

### FSM State Overview

| State Group | States | Description |
|---|---|---|
| Idle | `A` | Machine ready, awaiting coin input |
| Credit Accumulation | `B–G`, `Q–X` | Tracks inserted credit ($0.25 increments up to $3.75) |
| Dispense | `H` | Item successfully dispensed |
| Cancel/Refund | `I` | Full credit returned to user |
| Change Return | `J–P` | Returns exact change ($0.25 to $1.75) |

### Key Design Decisions

- **Moore FSM**: Outputs depend solely on the current state, not inputs — ensuring glitch-free, deterministic output behavior
- **Separated processes**: Sequential state register, combinational next-state logic, and output logic are implemented in three independent VHDL processes for clarity and synthesis efficiency
- **Debounce on all coin inputs**: Prevents false transitions from mechanical switch bounce

---

## 🔌 Port Interface

### Inputs

| Port | Type | Description |
|---|---|---|
| `clock` | STD_LOGIC | System clock |
| `reset` | STD_LOGIC | Synchronous global reset |
| `twentyfive` | STD_LOGIC | $0.25 coin insert pulse |
| `dollar` | STD_LOGIC | $1.00 coin insert pulse |
| `twodollars` | STD_LOGIC | $2.00 coin insert pulse |
| `cancel` | STD_LOGIC | Abort transaction, trigger refund |
| `confirm` | STD_LOGIC | Confirm purchase at current credit |

### Outputs

| Port | Type | Description |
|---|---|---|
| `dispense` | STD_LOGIC | High when item is dispensed |
| `ready` | STD_LOGIC | High when machine is idle |
| `ret` | STD_LOGIC | High during full refund |
| `coin` | STD_LOGIC | Pulses on valid coin acceptance |
| `A_G[6:0]` | STD_LOGIC_VECTOR | 7-segment display segments |
| `AN[7:0]` | STD_LOGIC_VECTOR | Display anode multiplexing control |
| `returntwentyfive` ... `returndollar` | STD_LOGIC | Change return denomination signals |

---

## 🛠️ Tools & Hardware

- **Language**: VHDL
- **Synthesis & Implementation**: Xilinx Vivado
- **Target FPGA**: Xilinx Artix-7 (XC7A35T) on a Digilent Basys 3 development board
- **Verification**: Behavioral simulation via VHDL testbench

---

## 🚀 Getting Started

1. Clone this repository
2. Open Xilinx Vivado and create a new project
3. Add all `.vhd` source files
4. Set `UpgradedVending_final` as the top-level module
5. Add your board constraints file (`.xdc`) mapping ports to physical FPGA pins
6. Run **Synthesis → Implementation → Generate Bitstream**

---

## 👤 Author

**Baitong Dong**  
McMaster University — Electrical and Computer Engineering
Cape Breton University — Electronic and Control Engineering Technology  
[LinkedIn](https://linkedin.com/in/baitong-dong) | baitong3@icloud.com
