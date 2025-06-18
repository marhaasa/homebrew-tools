class Sage < Formula
  include Language::Python::Virtualenv

  desc "Intelligent semantic tagging for markdown files using Claude"
  homepage "https://github.com/marhaasa/sage"
  url "https://github.com/marhaasa/sage/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "6558f8b522a8640a27a949efa8384563ee3cce4f5b9e1a1c8ea1076d8f099594"
  license "MIT"

  depends_on "python@3.12"

  resource "aiofiles" do
    url "https://files.pythonhosted.org/packages/source/a/aiofiles/aiofiles-24.1.0.tar.gz"
    sha256 "22a075c9dd35a059d8e701c4dbc7a73b99c9e9b7b3962d5afed35c5b31a7b2a8"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/source/c/click/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test version command
    assert_match "sage #{version}", shell_output("#{bin}/sage --version")
    
    # Test help command
    assert_match "Intelligent semantic tagging", shell_output("#{bin}/sage --help")
    
    # Test that commands are available
    assert_match "file", shell_output("#{bin}/sage --help")
    assert_match "dir", shell_output("#{bin}/sage --help")
    assert_match "files", shell_output("#{bin}/sage --help")
  end
end
