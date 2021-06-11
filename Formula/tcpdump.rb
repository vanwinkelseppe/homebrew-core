class Tcpdump < Formula
  desc "Command-line packet analyzer"
  homepage "https://www.tcpdump.org/"
  url "https://www.tcpdump.org/release/tcpdump-4.99.1.tar.gz"
  sha256 "79b36985fb2703146618d87c4acde3e068b91c553fb93f021a337f175fd10ebe"
  license "BSD-3-Clause"
  head "https://github.com/the-tcpdump-group/tcpdump.git"

  livecheck do
    url "https://www.tcpdump.org/release/"
    regex(/href=.*?tcpdump[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "603922412e7184c2f97aa7ab3757caad78105157ff486cd1fcd1fdc7b70c81ad"
    sha256 cellar: :any, big_sur:       "2cb0b061f9e2dbe9d36ab328fbec36e0c948d7db076ae03e11046d4c78ed0ea3"
    sha256 cellar: :any, catalina:      "f39b833288b92843f5e8aabb519a7bf4368476297abfbc718b7438d7cdb9f190"
    sha256 cellar: :any, mojave:        "91d13cf3a6c5bf4eb37c04ab5efb30e006316c7e0a91e4d657ca9589d22a45e0"
  end

  depends_on "libpcap"
  depends_on "openssl@1.1"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-smb",
                          "--disable-universal"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/tcpdump --help 2>&1")

    assert_match "tcpdump version #{version}", output
    assert_match "libpcap version #{Formula["libpcap"].version}", output
    assert_match "OpenSSL #{Formula["openssl@1.1"].version}", output

    assert_match "tcpdump: (cannot open BPF device) /dev/bpf0: Operation not permitted",
      shell_output("#{bin}/tcpdump ipv6 2>&1", 1)
  end
end
