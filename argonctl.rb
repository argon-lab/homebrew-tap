class Argonctl < Formula
  desc "MongoDB sandboxes for AI agents: branch, review, merge and undo your data"
  homepage "https://github.com/argon-lab/argon"
  url "https://github.com/argon-lab/argon/archive/refs/tags/v2.12.0.tar.gz"
  sha256 "6eef9cd63765c0fbd56d3f69298e2a33bb9ade4f227c960bdbdf6a71d2e61c59"
  license "MIT"
  head "https://github.com/argon-lab/argon.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    cd "cli" do
      ldflags = "-s -w -X github.com/argon-lab/argon/v2/pkg/version.Build=#{version}"
      system "go", "build", *std_go_args(ldflags:, output: bin/"argon")
    end
    bin.install_symlink "argon" => "argonctl"
  end

  test do
    assert_match "argon version #{version}", shell_output("#{bin}/argon --version")
    assert_match "argon version #{version}", shell_output("#{bin}/argonctl --version")
  end
end
