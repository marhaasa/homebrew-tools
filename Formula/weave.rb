class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/releases/download/v0.1.6/weave-0.1.6.tar.gz"
  sha256 "253942875a05c39b69479a2242bf2827fd58c19d43aabb5443e9957b7cafe151"
  license "MIT"
  version "0.1.6"
  
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
