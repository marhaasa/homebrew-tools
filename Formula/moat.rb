class Moat < Formula
  desc "Docker sandbox for Claude Code: allowlisted egress, no capabilities, .git masks"
  homepage "https://github.com/marhaasa/moat"
  url "https://github.com/marhaasa/moat.git",
      tag:      "v0.1.0",
      revision: "6946fc181c46a3252ea512ebf9cc03d39317691b"
  license "MIT"
  head "https://github.com/marhaasa/moat.git", branch: "main"

  depends_on "jq"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"moat", libexec/"moat-docker"
  end

  def caveats
    <<~EOS
      moat needs Docker (Docker Desktop, or Docker Engine on Linux) and a Claude
      Code login on this machine. The first `moat up` builds two images.

      Let Claude Code configure moat for you (links the skill into ~/.claude/skills):
        moat install
    EOS
  end

  test do
    assert_match "moat", shell_output("#{bin}/moat help")
  end
end
