class Argonctl < Formula
  desc "Git-like MongoDB branching for ML/AI workflows"
  homepage "https://github.com/argon-lab/argon"
  url "https://api.github.com/repos/argon-lab/argon/tarball/v1.0.1"
  sha256 "09b928deb6f12b62b0c0d9515c8ad4e293e3064b68d01f3849eb1bb83626dad4"
  license "MIT"
  head "https://github.com/argon-lab/argon.git", branch: "main"

  depends_on "go" => :build

  def install
    cd "cli" do
      system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"argon"
      # Create argonctl symlink for convenience
      bin.install_symlink "argon" => "argonctl"
    end
  end

  test do
    system "#{bin}/argon", "--version"
    system "#{bin}/argonctl", "--version"
    assert_match "argon version", shell_output("#{bin}/argon --version")
  end
end