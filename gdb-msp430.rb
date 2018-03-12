class GdbMsp430 < Formula
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://ftpmirror.gnu.org/gdb/gdb-7.2a.tar.bz2"
  sha256 "3c24dde332e33bfe2d5980c726d76224ebf8304278112a07bf701f8d2145d9bc"

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/gdb-7.2a/msp430-gdb-7.2a-20111205.patch"
    sha256 "b70b54df5e00d24a3a5b744545a87ce656bdc88546081c6ffabefbc4d6c42956"
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-msp430/mspgcc4/gdb-7.2a_libiberty-multilib.patch"
    sha256 "9bf1f5f8daab1ab72c5b0012d792f7a4cadaf252e1b51e576839a5a0e2e3c1a1"
  end

  def install
    target = "msp430"
    mkdir "build" do
      ENV["CFLAGS"] = "-Wno-error=return-type -Wno-error=size-pointer-memaccess -Wno-error=sometimes-uninitialized"
      system "../configure",
        "--target=#{target}",
        "--program-prefix=#{target}-",
        "--prefix=#{prefix}",
        "--disable-nls",
        "--disable-werror"
      system "make"
      system "make", "install"

      (lib/"libiberty.a").delete
      (share/"gdb").rmtree
      info.rmtree
    end
  end
end
