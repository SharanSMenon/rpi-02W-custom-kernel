# Raspberry Pi Zero 2W Bare Metal Kernel

This is a baremetal kernel for the Raspberry Pi Zero 2W. It can also work on a Raspberry Pi 3, since they both use the same chipset. I have not tested it on a Raspberry Pi 3, however.

## Features implemented

- Write to screen
- Draw on screen
- Write to serial console via UART
- Control power state
- Control GPIO
- Generate Random Numbers with hardware RNG
- Mailbox to communicate to VideoCore GPU
- Timer
- `sprintf` implemented for string operations/debugging


## Build instructions

I build this kernel on an Apple Silicon Mac using the Clang compiler installed with homebrew. You can install it via the `brew install llvm` commmand.
This makefile is designed for the clang compiler. If you are using another compiler (e.g `arm-gcc`), you will need to modify the makefile.

1. Clone this repository
2. Run the `make` command
3. Follow the setup directions in the microSD card setup section
4. Copy the `kernel8.img` file to a microSD card

### microSD card setup

1. Ensure the microSD card is formatted as FAT32.
2. From this [url](https://github.com/raspberrypi/firmware/tree/master/boot) (https://github.com/raspberrypi/firmware/tree/master/boot), copy `start.elf`, `bootcode.bin`, and `fixup.dat` to the microSD card.

You can also setup the microSD card by just installing Raspbian on the card and then removing all files that starts with `kernel`, replacing it with the one you built here.

When the Raspberry Pi Zero 2W boots, the GPU starts instead of the CPU. `bootcode.bin` is proprietary firmware for the GPU that will direct the GPU to boot the ARM CPU using the `kernel8.img` file. Mailboxes are used for CPU-GPU communication. 