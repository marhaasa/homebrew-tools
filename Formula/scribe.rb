class Scribe < Formula
  include Language::Python::Virtualenv

  desc "CLI for managing notes in Neovim + Obsidian"
  homepage "https://github.com/marhaasa/scribe"
  url "https://github.com/marhaasa/scribe/releases/download/v0.1.11/scribe-0.1.11.tar.gz"
  sha256 "74668c4276643dcbb097700cdf90d04af3661bc9daf0335f0d0cee9c9d426489"
  license "MIT"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/e3/f6/0a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/8e/62/8336eff65bcbc8e4cb5d05b55faf041285951b6e80f33e2bff2024788f31/pygments-2.18.0.tar.gz"
    sha256 "786ff802f32e91311bff3889f6e9a86e81505fe99f2735bb6d60ae0c5004f199"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/fc/1e/482f95e3cca83c866a179c3336a7571c935fc871467c55cb8ff9b4d0ae27/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/c5/58/a79003b91ac2c6890fc5d90145c662fd5771c6b1572e4c7b8d16d8e7d2a/typer-0.12.3.tar.gz"
    sha256 "49e73131481d804288ef62598d97a1ceef3058905aa536a1134f90891ba35482"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/df/db/f35a00659bc03fec321ba8bce9420de607a1d37f8342eee1863174c69557/typing_extensions-4.12.2.tar.gz"
    sha256 "1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"
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
