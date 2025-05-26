class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/releases/download/v0.1.6/weave-0.1.6.tar.gz"
  sha256 "992dddfbab61f3919f2d5882ea6c5f5c371abc9dc11def58ea88a848826f60a2"
  license "MIT"
  version "0.1.6"
  
  depends_on "node"

  def install
    # Check for Python and version
class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/releases/download/v0.1.6/weave-0.1.6.tar.gz"
  sha256 "992dddfbab61f3919f2d5882ea6c5f5c371abc9dc11def58ea88a848826f60a2"
  license "MIT"
  version "0.1.6"

  depends_on "node"

  def install
    libexec.install Dir["*"]

    # Only install production deps (no build)
    cd libexec do
      system "npm", "ci", "--omit=dev"
    end

    (bin/"weave").write <<~EOS
      #!/bin/bash
      cd "#{libexec}" || exit 1
      exec node "#{libexec}/bin/weave" "$@"
    EOS

    chmod 0755, bin/"weave"
  end

  def caveats
    <<~EOS
      This tool depends on:
        - Python 3.10+
        - Microsoft Fabric CLI (fab)

      To install Fabric CLI:
        pip install ms-fabric-cli
      Then login with:
        fab auth login
    EOS
  end

  test do
    assert_predicate bin/"weave", :exist?
    system "#{bin}/weave", "--version"
  end
end

