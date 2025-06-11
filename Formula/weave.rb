class Weave < Formula
    desc "An interactive TUI for Microsoft Fabric CLI"
    homepage "https://github.com/marhaasa/weave"
    url "https://github.com/marhaasa/weave/releases/download/v0.2.0/weave-0.2.0.tar.gz"
    sha256 "a0a2178f25b0bb028ad1159f60ca8a9b23d0fc69ecb1d3d7605631075aae79ac"
    license "MIT"
    version "0.2.0"

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
