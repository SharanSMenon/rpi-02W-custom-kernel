# Raspberry Pi Zero 2W Bare Metal Kernel

This is a baremetal kernel for the Raspberry Pi Zero 2W.

## Features implemented

- Write to screen
- Write to serial console via UART
- Control power state
- Control GPIO
- Generate Random Numbers with hardware RNG
- Mailbox to communicate to VideoCore GPU


## Build instructions

I build this kernel on an Apple Silicon Mac using the Clang compiler installed with XCode developer tools.
This makefile is designed for the clang compiler. If you are using another compiler, you will need to modify the makefile.

1. Clone this repository
2. Run the `make` command
3. Copy the `kernel8.img` file to a microSD card

### MicroSD card setup

1. Ensure the microsd card is formatted as FAT32
2. From this [url](https://github.com/raspberrypi/firmware/tree/master/boot) (https://github.com/raspberrypi/firmware/tree/master/boot), copy `start.elf`, `bootcode.bin`, and `fixup.dat` to the microSD card.

When the Raspberry Pi Zero 2W boots, the GPU starts instead of the CPU. `bootcode.bin` is proprietary firmware for the GPU that will direct the GPU to boot the ARM CPU using the `kernel8.img` file.