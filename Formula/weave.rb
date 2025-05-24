class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/releases/download/v0.1.3/weave-0.1.3.tar.gz"
  sha256 "6fd1f164f17f53e153831c4cc717578ab806a02a17d8435cc939964d6a35e8b8"
  license "MIT"
  version "0.1.3"
  
  depends_on "node"
  
  def install
    # Install all files to libexec
    libexec.install Dir["*"]
    
    # Install npm dependencies
    cd libexec do
      system "npm", "ci", "--production"
    end
    
    # Create wrapper script
    (bin/"weave").write <<~EOS
      #!/bin/bash
      export NODE_PATH="#{libexec}/node_modules"
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/weave.js" ""
    EOS
    
    # Make wrapper executable
    chmod 0755, bin/"weave"
  end
  
  test do
    assert_match "weave v", shell_output("#{bin}/weave --version")
  end
end
