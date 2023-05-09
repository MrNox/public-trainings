1. Compile the hello64.asm
2. Debugging with GDB

speak about objdump and symbols.

```
objdump -D hello64 -M intel | less
gdb -q hello64
disas _start
b _start or b *0x401000
r (r=run, c=continue)
set rdi=-1 (set -1 to see the next instruction)
si (high dword set to 0 :P)
```

