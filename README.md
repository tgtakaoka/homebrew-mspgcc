homebrew-mspgcc
===============

The [Homebrew][] formulae of GCC toolchain for MSP430, also known as
[MSPGCC][] which is based on [GNU GCC][] 4.7. This repository includes
`binutils-msp430`, `headers-msp430`, `gcc-msp430`, `libc-msp430`,
`gdb-msp430`.

To get everything, execute the following commands.

    $ brew tap tgtakaoka/mspgcc
    $ brew install libc-msp430 gdb-msp430
    $ brew install --HEAD tgtakaka/mspgcc/mspdebug

You may want to install `mspdebug-head` by the following commands.

    $ brew tap tgtakaoka/tinyos-msp430
    $ brew install --HEAD mspdebug-head

Version:

    binutils-msp430-2.22-20120911_1
    headers-msp430-20130321_1
    gcc-msp430-4.7.0-20120911_1
    libc-msp430-20120716_1
    gdb-msp430-7.2a-20111205_1

[Homebrew]: https://brew.sh/
[MSPGCC]: https://sourceforge.net/projects/mspgcc/
[GNU GCC]: https://gcc.gnu.org/
