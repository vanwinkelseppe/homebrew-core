class Azqr < Formula
  desc "Azure Quick Review"
  homepage "https://azure.github.io/azqr"
  url "https://github.com/Azure/azqr.git",
    tag:      "v.2.0.3",
    revision: "655239455eec8ac434b9ebc7a68af9c2b117499b"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X 'github.com/Azure/azqr/cmd/azqr.version=#{version}'"), "./cmd/main.go"

    generate_completions_from_executable(bin/"azqr", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/azqr -v")
  end
end
