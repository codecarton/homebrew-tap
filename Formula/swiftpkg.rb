class Swiftpkg < Formula
  desc "Build macOS installer packages from project directories"
  homepage "https://github.com/codecarton/swiftpkg"
  url "https://github.com/codecarton/swiftpkg/releases/download/v0.4.1/swiftpkg-0.4.1-universal.tar.gz"
  sha256 "9c3a066e8f9e44228e342fd3765eebcca2bc8bc47c63889c9aad4f041dbd7127"
  license "GPL-3.0-or-later"

  depends_on macos: :ventura

  def install
    bin.install "swiftpkg"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swiftpkg --version")
  end
end
