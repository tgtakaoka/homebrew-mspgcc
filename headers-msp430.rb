class HeadersMsp430 < Formula
  desc "msp430mcu, MSP430 specific header files"
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://downloads.sourceforge.net/project/mspgcc/msp430mcu/msp430mcu-20130321.tar.bz2"
  sha256 "01be411f8901362fab32e7e1be044a44e087a98f3bd2346ac167960cfe6fa221"
  revision 1

  def install
    target = "msp430"
    ENV["MSP430MCU_ROOT"] = Dir.pwd
    bin.mkdir
    system "./scripts/install.sh", "#{prefix}"

    target_lib = lib/target/"lib"
    target_lib.install Dir["#{prefix}/#{target}/lib/*"]

    target_include = include/target/"include"
    target_include.install Dir["#{prefix}/#{target}/include/*"]
  end
end
