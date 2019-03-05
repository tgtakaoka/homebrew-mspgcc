class HeadersMsp430 < Formula
  desc "msp430mcu, MSP430 specific header files"
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://downloads.sourceforge.net/project/mspgcc/msp430mcu/msp430mcu-20130321.tar.bz2"
  sha256 "01be411f8901362fab32e7e1be044a44e087a98f3bd2346ac167960cfe6fa221"
  revision 1

  def install
    target = "msp430"

    inreplace "scripts/install.sh" do |s|
      s.gsub! "INCPATH=${PREFIX}/#{target}/include", "INCPATH=${PREFIX}/include/#{target}/include"
      s.gsub! "LIBPATH=${PREFIX}/#{target}/lib", "LIBPATH=${PREFIX}/lib/#{target}/lib"
    end

    bin.mkdir
    ENV["MSP430MCU_ROOT"] = Dir.pwd
    system "./scripts/install.sh", "#{prefix}"
  end
end
