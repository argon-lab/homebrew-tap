class Argonctl < Formula
  desc "Git for MongoDB: branch, time-travel, merge and undo with real drivers"
  homepage "https://github.com/argon-lab/argon"
  url "https://github.com/argon-lab/argon/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "8a9325558745c3241094d4a2de858077c26ab20f1408910814f89b84937d5fb5"
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
