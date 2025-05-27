class Scribe < Formula
  include Language::Python::Virtualenv

  desc "CLI for managing notes in Neovim + Obsidian"
  homepage "https://github.com/marhaasa/scribe"
  url "https://github.com/marhaasa/scribe/releases/download/v0.1.13/scribe-0.1.13.tar.gz"
  sha256 "ef406e5ec5bf49f06f3e7daa40ec9b54ee6729d354a9f73f5e8c6a45cfe0fe96"
  license "MIT"

  depends_on "python@3.12"
  depends_on "poetry"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    system "poetry", "config", "virtualenvs.create", "false"
    system "poetry", "install", "--only=main", "--no-dev"
    bin.install_symlink libexec/"bin/scribe"
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
