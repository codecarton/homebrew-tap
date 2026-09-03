class Swiftpkg < Formula
  desc "Build macOS installer packages from project directories"
  homepage "https://github.com/codecarton/swiftpkg"
  url "https://github.com/codecarton/swiftpkg/releases/download/v0.4.0/swiftpkg-0.4.0-universal.tar.gz"
  sha256 "150782d3e2841619f19b58d6969e30c2b217250c451e8eaa7c3790104154b82e"
  license "GPL-3.0-or-later"

  depends_on macos: :ventura

  def install
    bin.install "swiftpkg"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swiftpkg --version")
  end
end
