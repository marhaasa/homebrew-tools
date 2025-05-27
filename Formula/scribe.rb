class Scribe < Formula
  include Language::Python::Virtualenv

  desc "CLI for managing notes in Neovim + Obsidian"
  homepage "https://github.com/marhaasa/scribe"
  url "https://github.com/marhaasa/scribe/releases/download/v0.1.14/scribe-0.1.14.tar.gz"
  sha256 "1192ebbb830a6a39fb4550c401171058f4d5ced463ca88edb862a6287fc544bf"
  license "MIT"

  depends_on "python@3.12"
  depends_on "poetry"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    system "poetry", "config", "virtualenvs.create", "false"
    system "poetry", "install", "--only=main"
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
