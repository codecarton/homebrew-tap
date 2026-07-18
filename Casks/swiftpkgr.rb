cask "swiftpkgr" do
  version "0.3.1"
  sha256 "094935a412722f6da2ff0c17d1a360d5789610b7fc3457ba5bdee952b03f24d6"

  url "https://github.com/codecarton/swiftpkg/releases/download/v#{version}/Swiftpkgr-#{version}.zip"
  name "Swiftpkgr"
  desc "Build installer packages with a native interface"
  homepage "https://github.com/codecarton/swiftpkg"

  depends_on macos: :sequoia

  app "Swiftpkgr.app"
end
