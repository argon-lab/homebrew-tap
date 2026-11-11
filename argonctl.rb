class Argonctl < Formula
  desc "Git for MongoDB: branch, time-travel, merge and undo with real drivers"
  homepage "https://github.com/argon-lab/argon"
  url "https://github.com/argon-lab/argon/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "6c5a69b4141a10729c0f4e2c76b41dd74679aeb71eb92fc3c1586a889832d01a"
  license "MIT"
  head "https://github.com/argon-lab/argon.git", branch: "master"

  depends_on "go" => :build

  def install
    cd "cli" do
      ldflags = "-s -w -X github.com/argon-lab/argon/v2/pkg/version.Build=#{version}"
      system "go", "build", *std_go_args(ldflags: ldflags), "-o", bin/"argon"
      # Create argonctl symlink for convenience
      bin.install_symlink "argon" => "argonctl"
    end
  end

  test do
    system "#{bin}/argon", "--version"
    system "#{bin}/argonctl", "--version"
    assert_match "argon version #{version}", shell_output("#{bin}/argon --version")
  end
end
