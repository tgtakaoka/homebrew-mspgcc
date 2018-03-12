homebrew-mspgcc
===============

The [Homebrew][] formulae of GCC toolchain for MSP430, also known as
[MSPGCC][] which is based on [GNU GCC][] 4.x, and [MSPDEBUG][]. This
repository includes `binutils-msp430`, `headers-msp430`, `gcc-msp430`,
`libc-msp430`, `gdb-msp430`, and `mspdebug`.

To get everything, execute the following commands.

    $ brew tap tgtakaoka/mspgcc
    $ brew install libc-msp430 gdb-msp430
    $ brew install --HEAD tgtakaka/mspgcc/mspdebug

Version:

    binutils-msp430-2.22-20120911
    headers-msp430-20130321
    gcc-msp430-4.7.0-20120911
    libc-msp430-20120716
    gdb-msp430-7.2a-20111205
    mspdebug-HEAD

[Homebrew]: https://brew.sh/
[MSPGCC]: https://sourceforge.net/projects/mspgcc/
[GNU GCC]: https://gcc.gnu.org/
[MSPDEBUG]: https://github.com/dlbeer/mspdebug
