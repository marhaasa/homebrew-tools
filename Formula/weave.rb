class Weave < Formula
    desc "An interactive TUI for Microsoft Fabric CLI"
    homepage "https://github.com/marhaasa/weave"
    url "https://github.com/marhaasa/weave/releases/download/v0.1.18/weave-0.1.18.tar.gz"
    sha256 "e5a68755c7583879f9b76abf1a9394bd9b204495a2ab3d219912a574a809e265"
    license "MIT"
    version "0.1.18"

    depends_on "node"

    def install
      libexec.install Dir["*"]

      # Use the project's own bin/weave script which handles module loading correctly
      (bin/"weave").write <<~EOS
        #!/bin/bash
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
