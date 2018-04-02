class TexinfoAT48 < Formula
  desc "Official documentation format of the GNU project"
  homepage "https://www.gnu.org/software/texinfo/"
  url "https://ftp.gnu.org/gnu/texinfo/texinfo-4.8.tar.bz2"
  mirror "https://ftpmirror.gnu.org/texinfo/texinfo-4.8.tar.bz2"
  sha256 "f6bb61fb9c1d6a65523c786a4a74ab61e455420469e09a86929f2d403d9a21bb"

  keg_only :provided_by_macos, <<~EOS
    software that uses TeX, such as lilypond and octave, require a newer
    version of these files
  EOS

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

    system "./configure", "--disable-dependency-tracking",
                          "--disable-install-warnings",
                          "--prefix=#{prefix}"
    system "make", "install"
    doc.install Dir["doc/refcard/txirefcard*"]
  end

  test do
    (testpath/"test.texinfo").write <<~EOS
      @ifnottex
      @node Top
      @top Hello World!
      @end ifnottex
      @bye
    EOS
    system "#{bin}/makeinfo", "test.texinfo"
    assert_match "Hello World!", File.read("test.info")
  end
end
