# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "rbconfig"
require "tmpdir"

class RenderPackagesTest < Minitest::Test
  SCRIPT = File.expand_path("../scripts/render-packages.rb", __dir__)
  VERSION = "1.2.3"
  CLI_URL = "https://github.com/codecarton/swiftpkg/releases/download/v1.2.3/swiftpkg-1.2.3-universal.tar.gz"
  APP_URL = "https://github.com/codecarton/swiftpkg/releases/download/v1.2.3/Swiftpkgr-1.2.3.zip"
  SHA256 = "a" * 64

  def test_renders_formula_and_cask
    Dir.mktmpdir do |directory|
      formula = File.join(directory, "Formula/swiftpkg.rb")
      cask = File.join(directory, "Casks/swiftpkgr.rb")
      _, error, status = render(CLI_URL, SHA256, APP_URL, SHA256, formula, cask)

      assert status.success?, error
      assert_includes File.read(formula), %(url "#{CLI_URL}")
      assert_includes File.read(formula), %(bin.install "swiftpkg")
      assert_includes(
        File.read(cask),
        %(url "https://github.com/codecarton/swiftpkg/releases/download/v\#{version}/Swiftpkgr-\#{version}.zip")
      )
      assert_includes File.read(cask), %(app "Swiftpkgr.app")
      refute_includes File.read(cask), "binary "
    end
  end

  def test_rejects_mismatched_release_url
    Dir.mktmpdir do |directory|
      _, error, status = render(
        CLI_URL.sub("v1.2.3", "v1.2.4"),
        SHA256,
        APP_URL,
        SHA256,
        File.join(directory, "formula.rb"),
        File.join(directory, "cask.rb")
      )

      refute status.success?
      assert_includes error, "CLI URL is not the immutable swiftpkg release artifact"
    end
  end

  def test_rejects_invalid_checksum
    Dir.mktmpdir do |directory|
      _, error, status = render(
        CLI_URL,
        "invalid",
        APP_URL,
        SHA256,
        File.join(directory, "formula.rb"),
        File.join(directory, "cask.rb")
      )

      refute status.success?
      assert_includes error, "invalid CLI SHA-256"
    end
  end

  private

  def render(cli_url, cli_sha256, app_url, app_sha256, formula, cask)
    Open3.capture3(
      RbConfig.ruby,
      SCRIPT,
      VERSION,
      cli_url,
      cli_sha256,
      app_url,
      app_sha256,
      formula,
      cask
    )
  end
end
