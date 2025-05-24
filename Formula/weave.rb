class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/releases/download/v0.1.4/weave-0.1.4.tar.gz"
  sha256 "c5c403ef1c5da0d286583f32f0853b916675cd40e01ba879f849c24e424632a8"
  license "MIT"
  version "0.1.4"
  
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
