# Tools:
- VMWare
- WinDbg or WinDbg Preview
- Visual Studio Community
- NASM
- GDB


# Procedure
- VMWare Virtual Machines
On any host: Two Windows 10 VM, and one Ubuntu VM (optional)
On Windows host: One Windows 10 VM, and one Ubuntu VM

- Install WinDbg or Windbg Preview from Windows Store (recommended)
On any host: Choose a Debugger VM and install inside it
On Windows host: Install WinDbg Preview inside it

# Windows kernel debugging environment
On any host:
- Choose the Debuggee VM
- Check in "Device Manager" how many COM ports there are. In my case only there is *one*
- Shutdown the Debuggee VM, and click in `VM->Settings` or `Ctrl+D`
- In Virtual Machine Settings click in `add->Serial Port`, choose `Use named pipe` and write `\\.\pipe\com_n`, `n` should be the next avaiable COM port, in my case is `\\.\pipe\com_2`, select `This end is the server` and `The other end is an application`, select `Yield CPU on poll`, and click OK
- Start up the Debuggee VM and verify the new COM port in "Device Manager"
- Start an CMD with administrator privileges, and write `bcdedit /debug on` and `bcdedit /dbgsettings serial debugport:n baudrate:115200`, `n` should be the new COM port created, in my case is `bcdedit /dbgsettings serial debugport:2 baudrate:115200`
- Reboot the Debuggee VM, you can use the command `shutdown -r -t 0`.

- Choose the Debugger VM
- Shutdown the Debuggee VM, and click in `VM->Settings` or `Ctrl+D`
- In "Virtual Machine Settings", clic in `add->Serial Port`, choose `Use named pipe` and write the same Debuggee VM pipe, in my case is `\\.\pipe\com_2`, select `This end is the client`, and `the other end is a virtual machine`, and click OK.
- Start up the Debuggee VM and verify the new COM port in "Device Manager"
- Start a CMD with administrator privileges and type, `WinDbgX -k com:resets=0,reconnect,port=COMn`, `n` should be the new COM port created, in my case is `WinDbgX -k com:resets=0,reconnect,port=COM2`

*Important:*
The same COM port will be avaible in Debuggee VM and Debugger VM, verify that in "Device Manager".

On Windows host, choose the Debuggee VM:		
- Install and follow the next instructions https://github.com/4d61726b/VirtualKD-Redux

# WinDbg debugging
- Following the nexts instructions, https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/symbol-path 
- The most important is set the symbol path creating an environment variable called `_NT_SYMBOL_PATH `

# Set environment On Ubuntu Virtual Machine
- On Ubuntu:
```
sudo apt install gdb-multiarch nasm
bash -c "$(wget https://gef.blah.cat/dev -O -)"
wget https://raw.githubusercontent.com/hugsy/gef/dev/scripts/gef-extras.sh
chmod +x ./gef-extras.sh
./gef-extras -b dev
```
