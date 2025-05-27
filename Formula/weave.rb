class Weave < Formula
    desc "An interactive TUI for Microsoft Fabric CLI"
    homepage "https://github.com/marhaasa/weave"
    url "https://github.com/marhaasa/weave/releases/download/v0.1.17/weave-0.1.17.tar.gz"
    sha256 "a599e8eb63df2af4087e32075bf1b1b2d9b84936bffa3cd0f9801faff2a35938"
    license "MIT"
    version "0.1.17"

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
