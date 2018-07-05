class GccMsp430 < Formula
  desc "GNU C ompiler for MSP430 MCUs"
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://ftpmirror.gnu.org/gcc/gcc-4.7.0/gcc-4.7.0.tar.bz2"
  sha256 "a680083e016f656dab7acd45b9729912e70e71bbffcbf0e3e8aa1cccf19dc9a5"
  version "4.7.0-20120911"
  revision 1

  depends_on "binutils-msp430"
  depends_on "headers-msp430"
  depends_on "mpfr" => :build if OS.mac?
  depends_on "gmp" => :build if OS.mac?
  depends_on "libmpc" => :build if OS.mac?
  depends_on "texinfo@4.8" => :build if OS.linux?

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/gcc-4.7.0/msp430-gcc-4.7.0-20120911.patch"
    sha256 "db0b6e502c89be4cfee518e772125eaea66cc289d9428c57ddcc187a3be9e77a"
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-mspgcc/master/patches/gcc-4.7.0-patches.tar.xz"
    sha256 "0095576b979de004d626b527797e12be81d1683bfc570f8d28504bcb6cf13272"
    apply "gcc-4.7.0_PR-54638.patch"
    apply "gcc-4.7.0_gperf.patch"
    apply "gcc-4.7.0_libiberty-multilib.patch"
  end

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
    ENV.remove_from_cflags "-Qunused-arguments"
    ENV.remove_from_cflags(/ ?-march=\S*/)
    ENV.remove_from_cflags(/ ?-msse[\d\.]*/)
    ENV.remove_from_cflags(/ ?-mmacosx-version-min=10\.\d+/)

    target = "msp430"
    # languages = "c,c++"
    languages = "c" 
    # gcc must be built outside of the source directory.
    mkdir "build" do
      system "../configure",
        "--target=#{target}",
        "--program-prefix=#{target}-",
        "--prefix=#{prefix}",
        "--enable-languages=#{languages}",
        "--with-as=#{HOMEBREW_PREFIX}/bin/#{target}-as",
        "--with-ld=#{HOMEBREW_PREFIX}/bin/#{target}-ld",
        "--with-system-zlib",
        "--disable-nls",
        "--disable-werror"
      system "make"
      system "make", "install"
    end

    (lib/"libiberty.a").delete
    info.rmtree
    (man/"man7").rmtree

    target_lib = HOMEBREW_PREFIX/"lib/#{target}/lib"
    (lib/target).install Dir["#{prefix}/#{target}/lib/*"]
    (prefix/target/"lib").rmtree
    (prefix/target).install_symlink target_lib

    target_include = HOMEBREW_PREFIX/"include/#{target}/include"
    (prefix/target).install_symlink target_include
  end
end
