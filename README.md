# Homebrew tap for swiftpkg

This is the official Homebrew tap for
[`codecarton/swiftpkg`](https://github.com/codecarton/swiftpkg).

The `swiftpkg` formula and `swiftpkgr` cask are created and updated together by
pull request after a signed, notarized swiftpkg release publishes checksummed
Universal 2 CLI and app archives. Until that first verified release update is
merged, this tap intentionally does not expose either package.

Once the packages are available:

```sh
brew install codecarton/tap/swiftpkg
brew upgrade swiftpkg
brew uninstall swiftpkg
```

Every automated update is audited, installed from source, and tested on macOS
before its pull request is opened.
