class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/releases/download/v0.1.7/weave-0.1.7.tar.gz"
  sha256 "55c0fdd4ef946b6e3244de7f585b545ea21f082555f660546d155ed92533e071"
  license "MIT"
  version "0.1.7"

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
      exec node "#{libexec}/dist/weave.js" "$@"
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

