class Argonctl < Formula
  desc "Git-like MongoDB branching for ML/AI workflows"
  homepage "https://github.com/argon-lab/argon"
  url "https://api.github.com/repos/argon-lab/argon/tarball/v1.0.0"
  sha256 "b889227bbab566b61b9b865612af04e9a2a0d95e9686f1bb60e6b0ff68f16149"
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