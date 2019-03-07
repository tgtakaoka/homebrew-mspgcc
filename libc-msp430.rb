class LibcMsp430 < Formula
  desc "msp430-libc, C library for MSP430 MCUs"
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://downloads.sourceforge.net/project/mspgcc/msp430-libc/msp430-libc-20120716.tar.bz2"
  sha256 "cbd78f468e9e3b2df9060f78e8edb1b7bfeb98a9abfa5410d23f63a5dc161c7d"
  revision 2

  depends_on "gcc-msp430"

  def install
    target = "msp430"
    system "./configure", "--prefix=#{prefix}"
    Dir.chdir "src" do
      system "make"
      system "make", "install"
    end

    # Move libraries and headers to where gcc-msp430 can refer.
    (lib/target/"lib").install Dir[prefix/target/"lib/*"]
    (include/target/"include").install Dir[prefix/target/"include/*"]
  end
end
