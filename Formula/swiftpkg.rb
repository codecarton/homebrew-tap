class Swiftpkg < Formula
  desc "Build macOS installer packages from project directories"
  homepage "https://github.com/codecarton/swiftpkg"
  url "https://github.com/codecarton/swiftpkg/releases/download/v0.3.1/swiftpkg-0.3.1-universal.tar.gz"
  sha256 "35b4f86c32bf9fab31f8a09a94fa9a35d93bc1b7d2bc966b4305cfd9134ff6a8"
  license "GPL-3.0-or-later"

  depends_on macos: :ventura

  def install
    bin.install "swiftpkg"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swiftpkg --version")
  end
end
