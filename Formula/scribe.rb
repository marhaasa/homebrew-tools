class Scribe < Formula
  include Language::Python::Virtualenv

  desc "CLI for managing notes in Neovim + Obsidian"
  homepage "https://github.com/marhaasa/scribe"
  url "https://github.com/marhaasa/scribe/archive/refs/tags/v0.1.31.tar.gz"
  sha256 "512d79ddcb1b43209e699a249aaa9ef7d6b2aa27bc83eaf4606e327af8a5ea46"
  license "MIT"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/py3/c/click/click-8.1.7-py3-none-any.whl"
    sha256 "ae74fb96c20a0277a1d615f1e4d73c8414f5a98db8b799a7931d1582f3390c28"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/py3/m/markdown_it_py/markdown_it_py-3.0.0-py3-none-any.whl"
    sha256 "355216845c60bd96232cd8d8c40e8f9765cc86f46880e43a8fd22dc1a1a8cab1"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/py3/m/mdurl/mdurl-0.1.2-py3-none-any.whl"
    sha256 "84008a41e51615a49fc9966191ff91509e3c40b939176e643fd50a5c2196b8f8"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/py3/p/pygments/pygments-2.18.0-py3-none-any.whl"
    sha256 "b8e6aca0523f3ab76fee51799c488e38782ac06eafcf95e7ba832985c8e7b13a"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/py3/r/rich/rich-13.7.1-py3-none-any.whl"
    sha256 "4edbae314f59eb482f54e9e30bf00d33350aaa94f4bfcd4e9e3110e64d0d7222"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/py2.py3/s/shellingham/shellingham-1.5.4-py2.py3-none-any.whl"
    sha256 "7ecfff8f2fd72616f7481040475a65b2bf8af90a56c89140852d1120324e8686"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/py3/t/typer/typer-0.12.3-py3-none-any.whl"
    sha256 "070d7ca53f785acbccba8e7d28b08dcd88f79f1fbda035ade0aecec71ca5c914"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/py3/t/typing_extensions/typing_extensions-4.12.2-py3-none-any.whl"
    sha256 "04e5ca0351e0f3f85c6853954072df659d0d13fac324d0072316b67d7794700d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test version flag
    assert_match "scribe version #{version}", shell_output("#{bin}/scribe --version")

    # Test help command
    assert_match "A CLI for managing notes", shell_output("#{bin}/scribe --help")

    # Test that commands are available
    assert_match "daily", shell_output("#{bin}/scribe --help")
    assert_match "new", shell_output("#{bin}/scribe --help")
  end
end
