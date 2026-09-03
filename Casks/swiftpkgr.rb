cask "swiftpkgr" do
  version "0.4.0"
  sha256 "f78a7ce4b30ad7d144b689c611f7e2a1d3454c77bb00bd13ecff53ebaa9cdc8d"

  url "https://github.com/codecarton/swiftpkg/releases/download/v#{version}/Swiftpkgr-#{version}.zip"
  name "Swiftpkgr"
  desc "Build installer packages with a native interface"
  homepage "https://github.com/codecarton/swiftpkg"

  depends_on macos: :sequoia

  app "Swiftpkgr.app"
end
