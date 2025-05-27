class Scribe < Formula
include Language::Python::Virtualenv

desc "CLI for managing notes in Neovim + Obsidian"
homepage "https://github.com/marhaasa/scribe"
url "https://github.com/marhaasa/scribe/archive/refs/tags/v0.1.5.tar.gz"
sha256 "ab2b5743049ff2b25ad5e31353c5e006f2394e44d514f814fa53f33c7f7dad5f"
license "MIT"
head "https://github.com/marhaasa/scribe.git", branch: "main"

depends_on "python@3.12"

def install
  # Create virtual environment
  venv = virtualenv_create(libexec, "python3.12")

  # Upgrade pip for better wheel support
  system libexec/"bin/pip", "install", "--upgrade", "pip"

  # Install the package and all dependencies using pip
  # This uses pre-built wheels from PyPI which is much faster
  system libexec/"bin/pip", "install", buildpath

  # Link the executable
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
