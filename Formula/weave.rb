class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  head "https://github.com/marhaasa/weave.git", branch: "main"

  depends_on "node"

  def install
    # Install all application files to libexec
    libexec.install Dir["*"]
    
    # Install npm dependencies
    cd libexec do
      system "npm", "ci", "--production"
    end
    
    # Create wrapper script
    (bin/"weave").write <<~EOS
      #!/bin/bash
      export NODE_PATH="#{libexec}/node_modules"
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/weave.js" "$@"
    EOS
    
    # Make wrapper executable
    chmod 0755, bin/"weave"
  end

  test do
    # Test that the binary executes without error
    assert_match "weave v", shell_output("#{bin}/weave --version")
  end
end
