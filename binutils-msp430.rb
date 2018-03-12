class BinutilsMsp430 < Formula
  homepage "http://mspgcc.sourceforge.net"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.22.tar.gz"
  sha256 "12c26349fc7bb738f84b9826c61e103203187ca2d46f08b82e61e21fcbc6e3e6"

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/binutils-2.22/msp430-binutils-2.22-20120911.patch"
    sha256 "1dc3cfb0eac093b5f016f4264b811b4352515e8a3519c91240c73bacd256a667"
  end

  def install
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

    (lib/"libiberty.a").rmtree
    info.rmtree

    target_bin = bin/target
    target_bin.mkpath
    target_bin.install Dir["#{prefix}/#{target}/bin/*"]

    target_lib = lib/target/"lib"
    target_lib.mkpath
    target_lib.install Dir["#{prefix}/#{target}/lib/*"]

    target_include = include/target/"include"
    target_include.mkpath
    target_include.install Dir["#{prefix}/#{target}/include/*"]
  end
end
