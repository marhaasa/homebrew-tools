class Scribe < Formula
  include Language::Python::Virtualenv

  desc "CLI for managing notes in Neovim + Obsidian"
  homepage "https://github.com/marhaasa/scribe"
  url "https://github.com/marhaasa/scribe/releases/download/v0.1.20/scribe-0.1.20-py3-none-any.whl"
  sha256 "448644723ad99241b884edd6898ded2ddc9a09cf6bb27bacd6439077dd83af41"
  license "MIT"

  depends_on "python@3.12"

  resource "typer" do
    url "https://files.pythonhosted.org/packages/c5/58/a79003b91ac2c6890fc5d90145c662fd5771c6b1572e4c7b8d16d8e7d2a/typer-0.12.3.tar.gz"
    sha256 "49e73131481d804288ef62598d97a1ceef3058905aa536a1134f90891ba35482"
  end

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
