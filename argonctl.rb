class Argonctl < Formula
  desc "Git for MongoDB: branch, time-travel, merge and undo with real drivers"
  homepage "https://github.com/argon-lab/argon"
  url "https://github.com/argon-lab/argon/archive/refs/tags/v2.1.1.tar.gz"
  sha256 "3d556e471950513ebeadc743d6f2691cdbac94d917a8bcff3a08b5587815ed84"
  license "MIT"
  head "https://github.com/argon-lab/argon.git", branch: "master"

  depends_on "go" => :build

  def install
    cd "cli" do
      ldflags = "-s -w -X github.com/argon-lab/argon/pkg/version.Build=#{version}"
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
