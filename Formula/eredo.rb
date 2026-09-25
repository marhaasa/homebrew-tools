class Eredo < Formula
  desc "Docker sandbox for Claude Code: allowlisted egress, no root, no privileges, .git masks"
  homepage "https://github.com/marhaasa/eredo"
  url "https://github.com/marhaasa/eredo.git",
      tag:      "v0.3.1",
      revision: "62b97ab4efe6250ab7986f4b3042d76ca5b80408"
  license "MIT"
  head "https://github.com/marhaasa/eredo.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w", output: bin/"eredo")
  end

  def caveats
    <<~EOS
      eredo needs Docker (Docker Desktop, or Docker Engine on Linux) and a Claude
      Code login on this machine. The first `eredo up` builds two images.

      Let Claude Code configure eredo for you (writes the skill to ~/.claude/skills):
        eredo install
    EOS
  end

  test do
    assert_match "eredo", shell_output("#{bin}/eredo version")
  end
end
