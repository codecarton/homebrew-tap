# Homebrew tap for swiftpkg

This is the official Homebrew tap for
[`codecarton/swiftpkg`](https://github.com/codecarton/swiftpkg).

The `swiftpkg` formula is created and updated by pull request after a signed,
notarized swiftpkg release publishes its checksummed Universal 2 CLI archive.
Until that first verified release update is merged, this tap intentionally
does not expose a formula.

Once the formula is available:

```sh
brew install codecarton/tap/swiftpkg
brew upgrade swiftpkg
brew uninstall swiftpkg
```

Every automated update is audited, installed from source, and tested on macOS
before its pull request is opened.
