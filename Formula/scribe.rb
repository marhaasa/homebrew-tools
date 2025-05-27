class Scribe < Formula
  include Language::Python::Virtualenv

  desc "CLI for managing notes in Neovim + Obsidian"
  homepage "https://github.com/marhaasa/scribe"
  url "https://github.com/marhaasa/scribe/releases/download/v0.1.9/scribe-0.1.9.tar.gz"
  sha256 "1f8e165dfec5d55f339175c9ef8d574e424a908d07137388d49e196e4da67332"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test version command
    assert_match "scribe version #{version}", shell_output("#{bin}/scribe version")
    
    # Test help command
    assert_match "A CLI for managing notes", shell_output("#{bin}/scribe --help")
    
    # Test that commands are available
    assert_match "daily", shell_output("#{bin}/scribe --help")
    assert_match "new", shell_output("#{bin}/scribe --help")
  end
end
