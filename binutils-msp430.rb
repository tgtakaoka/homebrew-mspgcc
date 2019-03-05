class BinutilsMsp430 < Formula
  desc "GNU assembler, linker, and binaru utilities for MSP430 MCUs"
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.22.tar.gz"
  sha256 "12c26349fc7bb738f84b9826c61e103203187ca2d46f08b82e61e21fcbc6e3e6"
  version "2.22-20120911"
  revision 1

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/binutils-2.22/msp430-binutils-2.22-20120911.patch"
    sha256 "1dc3cfb0eac093b5f016f4264b811b4352515e8a3519c91240c73bacd256a667"
  end

  depends_on "texinfo@4.8" => :build if OS.linux?

  resource "config" do
    url "https://git.savannah.gnu.org/git/config.git"
  end

  def install
    # Update config.guess and config.sub to be able to handle newer
    # architechture such as aarch64.
    resource("config").stage do
      buildpath.install "config.guess"
      buildpath.install "config.sub"
    end

    ENV.prepend_path "PATH", Formula["texinfo@4.8"].opt_prefix/"bin" if OS.linux?
    target = "msp430"
    mkdir "build" do
      system "../configure",
        "--target=#{target}",
        "--program-prefix=#{target}-",
        "--prefix=#{prefix}",
        "--disable-static",
        "--disable-nls",
        "--disable-werror"
      system "make"
      system "make", "install"
    end

    (lib/"libiberty.a").delete
    info.rmtree

    target_bin = bin/target
    target_bin.install Dir[prefix/target/"bin/*"]
    (prefix/target/"bin").rmdir

    # Can not simply install symbolic links under lib/target/lib because
    # lib/target/lib/ldscripts conflicts with headers-msp430.
    target_lib = lib/target/"lib"
    target_lib.install Dir[prefix/target/"lib/*"]
    (prefix/target/"lib").rmtree
    (prefix/target).install_symlink target_lib
  end
end
