class GccMsp430 < Formula
  desc "GNU C ompiler for MSP430 MCUs"
  homepage "https://sourceforge.net/projects/mspgcc/"
  url "https://ftpmirror.gnu.org/gcc/gcc-4.7.0/gcc-4.7.0.tar.bz2"
  sha256 "a680083e016f656dab7acd45b9729912e70e71bbffcbf0e3e8aa1cccf19dc9a5"

  depends_on "binutils-msp430"
  depends_on "headers-msp430"
  depends_on "mpfr"
  depends_on "gmp"
  depends_on "libmpc"

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/gcc-4.7.0/msp430-gcc-4.7.0-20120911.patch"
    sha256 "db0b6e502c89be4cfee518e772125eaea66cc289d9428c57ddcc187a3be9e77a"
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-msp430/mspgcc4/gcc-4.7.0_PR-54638.patch"
    sha256 "ca223db60861c23795355cd7be30539d64ef2b290b3cdfbb7d838a4ce1b37bf7"
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-msp430/mspgcc4/gcc-4.7.0_gperf.patch"
    sha256 "b491390432e33d64d136d85a14a7af6946941a81a8bf9fe4b95cb00deab53c1d"
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-msp430/mspgcc4/gcc-4.7.0_libiberty-multilib.patch"
    sha256 "4fb8e588fb1db8bc524427cba761ea1ad7f4df3842612b7c30b43c097b214464"
  end

  def install
    ENV.remove_from_cflags "-Qunused-arguments"
    ENV.remove_from_cflags(/ ?-march=\S*/)
    ENV.remove_from_cflags(/ ?-msse[\d\.]*/)
    ENV.remove_from_cflags(/ ?-mmacosx-version-min=10\.\d+/)

    target = "msp430"
    # gcc must be built outside of the source directory.
    mkdir "build" do
      system "../configure",
        "--target=#{target}",
        "--program-prefix=#{target}-",
        "--prefix=#{prefix}",
        "--enable-languages=c,c++",
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
