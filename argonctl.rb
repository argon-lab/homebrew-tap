class Argonctl < Formula
  desc "MongoDB sandboxes for AI agents: branch, review, merge and undo your data"
  homepage "https://github.com/argon-lab/argon"
  url "https://github.com/argon-lab/argon/archive/refs/tags/v2.13.0.tar.gz"
  sha256 "7efd38dceba7f4a6506c3a3b519592f88e4eb22cb0c0b33345f2f270510b82a9"
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
