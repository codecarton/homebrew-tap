cask "swiftpkgr" do
  version "0.4.1"
  sha256 "778e5fd951caac429c8b46fc54d94bd8c3689ee553a7f4169de78a46778006ca"

  url "https://github.com/codecarton/swiftpkg/releases/download/v#{version}/Swiftpkgr-#{version}.zip"
  name "Swiftpkgr"
  desc "Build installer packages with a native interface"
  homepage "https://github.com/codecarton/swiftpkg"

  depends_on macos: :sequoia

  app "Swiftpkgr.app"
end
