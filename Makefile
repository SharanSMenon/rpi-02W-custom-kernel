CFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -mcpu=cortex-a53+nosimd
CC = clang
LLVMPATH = /opt/homebrew/opt/llvm/bin
OUT_DIR = build
SRC_DIR = src
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OUT_DIR)/%.o)

all: clean kernel8.img

$(OUT_DIR)/start.o: start.S
	$(LLVMPATH)/$(CC) --target=aarch64-elf $(CFLAGS) -c $< -o $@

$(OUT_DIR)/%.o: $(SRC_DIR)/%.c
	$(LLVMPATH)/$(CC) --target=aarch64-elf $(CFLAGS) -c $< -o $@

$(OUT_DIR)/font_psf.o: fonts/font.psf
	$(LLVMPATH)/ld.lld -m aarch64elf -r -b binary -o $@ $<

$(OUT_DIR)/font_sfn.o: fonts/font.sfn
	$(LLVMPATH)/ld.lld -m aarch64elf -r -b binary -o $@ $<

kernel8.img: $(OUT_DIR)/start.o $(OUT_DIR)/font_psf.o $(OUT_DIR)/font_sfn.o  $(OBJS)
	$(LLVMPATH)/ld.lld -m aarch64elf -nostdlib $(OUT_DIR)/start.o $(OUT_DIR)/font_psf.o $(OUT_DIR)/font_sfn.o $(OBJS) -T link.ld -o kernel8.elf
	$(LLVMPATH)/llvm-objcopy -O binary kernel8.elf kernel8.img


clean:
	rm kernel8.elf *.o build/*.o> /dev/null 2>/dev/null || true

run:
	qemu-system-aarch64 -M raspi3b -kernel kernel8.img  -serial stdio
