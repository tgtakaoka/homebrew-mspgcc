class BinutilsMsp430 < Formula
  desc "GNU assembler, linker, and binaru utilities for MSP430 MCUs"
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.22.tar.gz"
  sha256 "12c26349fc7bb738f84b9826c61e103203187ca2d46f08b82e61e21fcbc6e3e6"
  version "2.22-20120911"
  revision 4

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

    # Remove unnecessary files.
    (lib/"libiberty.a").delete
    info.rmtree

    # Create symlinks to no-prefix binaries as bin/target.
    bin.install_symlink prefix/target/"bin" => target

    # Create empty place holders for gcc-msp430 and libc-msp430
    target_lib = HOMEBREW_PREFIX/"lib/#{target}/lib"
    target_include = HOMEBREW_PREFIX/"include/#{target}/include"
    target_lib.mkpath
    target_include.mkpath
    # Move target/lib to lib/target/lib
    (lib/target).install prefix/target/"lib"
    # Create symlink for msp430-ld to see linker scripts from
    # headers-msp430.
    (prefix/target).install_symlink target_lib
  end
end
