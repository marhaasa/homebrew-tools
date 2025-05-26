class Weave < Formula
  desc "An interactive TUI for Microsoft Fabric CLI"
  homepage "https://github.com/marhaasa/weave"
  url "https://github.com/marhaasa/weave/releases/download/v0.1.5/weave-0.1.5.tar.gz"
  sha256 "217dd242577ca467c7a44a0cad634598848deaf9ae31071a90a25e85eafe27f2"
  license "MIT"
  version "0.1.5"
  
  depends_on "node"

  def install
    # Check for Python and version
    python_version = check_python_version
    unless python_version
      odie <<~EOS
        Python 3.10 or higher is required but not found!
        
        Please install Python 3.10+ using one of these methods:
          - Homebrew: brew install python@3.11
          - Official installer: https://www.python.org/downloads/
        
        Microsoft Fabric CLI requires Python 3.10 or higher.
      EOS
    end

    # Check for Microsoft Fabric CLI
    unless which("fab")
      opoo <<~EOS
        Microsoft Fabric CLI (fab) not found!
        
        weave requires the Fabric CLI to be installed. Please install it using:
          pip install ms-fabric-cli
          
        Or if you're using Python from Homebrew:
          python3 -m pip install ms-fabric-cli
        
        After installation, authenticate with:
          fab auth login
      EOS
    end

   # Install all files to libexec
    libexec.install Dir["*"]
    
    # Install and build
    cd libexec do
      # Install all dependencies
      system "npm", "ci"
      
      # Build TypeScript to JavaScript
      system "npm", "run", "build"
      
      # Remove dev dependencies to save space
      system "npm", "prune", "--production"
    end
    
    # Create wrapper script
    (bin/"weave").write <<~EOS
      #!/bin/bash
      cd "#{libexec}" || exit 1
      exec node "#{libexec}/bin/weave" "$@"
    EOS

    chmod 0755, bin/"weave"

  end

  def check_python_version
    # Try different Python commands
    python_commands = ["python3", "python"]
    
    python_commands.each do |cmd|
      next unless which(cmd)
      
      begin
        version_output = Utils.safe_popen_read(cmd, "--version").strip
        if version_match = version_output.match(/Python (\d+)\.(\d+)\.(\d+)/)
          major = version_match[1].to_i
          minor = version_match[2].to_i
          
          # Check if version is 3.10 or higher
          if major == 3 && minor >= 10
            return "#{major}.#{minor}.#{version_match[3]}"
          end
        end
      rescue
        # Continue to next command if this one fails
        next
      end
    end
    
    # No suitable Python found
    return nil
  end

  def caveats
    python_info = if which("python3")
      python_version = Utils.safe_popen_read("python3", "--version").strip
      "✓ #{python_version} detected"
    else
      "⚠ Python 3.10+ required - please install if not present"
    end
    
    fab_info = if which("fab")
      "✓ Microsoft Fabric CLI detected"
    else
      "⚠ Microsoft Fabric CLI required - install with: pip install fabric-cli"
    end

    <<~EOS
      Prerequisites status:
        #{python_info}
        #{fab_info}
      
      To complete setup:
      
      1. Ensure Python 3.10+ is installed:
         brew install python@3.11
      
      2. Install Microsoft Fabric CLI (if not already installed):
         pip install fabric-cli
      
      3. Authenticate with Fabric:
         fab auth login
      
      4. Run 'weave' to start the TUI
    EOS
  end

  test do
    assert_predicate bin/"weave", :exist?
    
    # Check Node.js is available
    system "node", "--version"
    
    # Check Python version
    python_version = check_python_version
    assert python_version, "Python 3.10+ is required"
    
    # Optionally check if fab exists (won't fail test if missing)
    if which("fab")
      system "fab", "--version"
    end
  end
end
