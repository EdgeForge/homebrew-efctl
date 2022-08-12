require "language/node"
require_relative "../custom_download_strategy"

class Efctl < Formula
    desc "CLI to use EdgeForge"
    homepage "https://github.com/EdgeForge/efctl"
    url "https://github.com/EdgeForge/efctl/archive/refs/tags/v0.0.3.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "87f51fdd64c3e8895ec4dd7c09d06f53dc9b3d36fe5d3b4bb9f62805b990903d"
    head "https://github.com/EdgeForge/efctl.git"
    version "0.0.3"

    depends_on "node" => :build

    def install

        system "npm", "install", *Language::Node.local_npm_install_args
        source "./init.sh"
        build
        release "0.0.3"
        
        chdir "dist\bin\0.0.3" do
            bin.install (OS.linux? ? "efctl-linux" : "efctl-macos") => efctl
        end
    end

    # Homebrew requires tests.
    test do
        # assert_match "efctl version 0.0.3", shell_output("#{bin}/efctl -v", 2)
        system "false"
    end
end