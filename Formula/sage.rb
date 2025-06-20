class Sage < Formula
  include Language::Python::Virtualenv

  desc "Intelligent semantic tagging for markdown files using Claude"
  homepage "https://github.com/marhaasa/sage"
  url "https://github.com/marhaasa/sage/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "a404bda6155add8d6f1ad40e54b30dd71574a61a3cc10fb2cbb9d738dc1a4871"
  license "MIT"

  depends_on "python@3.12"

  resource "aiofiles" do
    url "https://files.pythonhosted.org/packages/source/a/aiofiles/aiofiles-23.2.1.tar.gz"
    sha256 "84ec2218d8419404abcb9f0c02df3f34c6e0a68ed41072acfb1cef5cbc29051a"
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
