#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "uri"

version, cli_url, cli_sha256, app_url, app_sha256, formula_output, cask_output = ARGV
unless cask_output
  abort "usage: render-packages.rb VERSION CLI_URL CLI_SHA256 APP_URL APP_SHA256 FORMULA_OUTPUT CASK_OUTPUT"
end

abort "invalid semantic version" unless version.match?(/\A\d+\.\d+\.\d+\z/)

{
  "CLI" => cli_sha256,
  "app" => app_sha256,
}.each do |name, checksum|
  abort "invalid #{name} SHA-256" unless checksum.match?(/\A[0-9a-f]{64}\z/)
end

def validate_release_url(url, expected_path, artifact)
  uri = URI.parse(url)
  valid = uri.scheme == "https" &&
          uri.host == "github.com" &&
          uri.path == expected_path &&
          !uri.query &&
          !uri.fragment
  abort "#{artifact} URL is not the immutable swiftpkg release artifact" unless valid
rescue URI::InvalidURIError
  abort "invalid #{artifact} URL"
end

release_path = "/codecarton/swiftpkg/releases/download/v#{version}"
validate_release_url(
  cli_url,
  "#{release_path}/swiftpkg-#{version}-universal.tar.gz",
  "CLI"
)
validate_release_url(
  app_url,
  "#{release_path}/Swiftpkgr-#{version}.zip",
  "app"
)

formula = <<~RUBY
  class Swiftpkg < Formula
    desc "Build macOS installer packages from project directories"
    homepage "https://github.com/codecarton/swiftpkg"
    url "#{cli_url}"
    sha256 "#{cli_sha256}"
    license "GPL-3.0-or-later"

    depends_on macos: :ventura

    def install
      bin.install "swiftpkg"
    end

    test do
      assert_match version.to_s, shell_output("\#{bin}/swiftpkg --version")
    end
  end
RUBY

cask = <<~RUBY
  cask "swiftpkgr" do
    version "#{version}"
    sha256 "#{app_sha256}"

    url "https://github.com/codecarton/swiftpkg/releases/download/v\#{version}/Swiftpkgr-\#{version}.zip"
    name "Swiftpkgr"
    desc "Build installer packages with a native interface"
    homepage "https://github.com/codecarton/swiftpkg"

    depends_on macos: :sequoia

    app "Swiftpkgr.app"
  end
RUBY

FileUtils.mkdir_p(File.dirname(formula_output))
FileUtils.mkdir_p(File.dirname(cask_output))
File.write(formula_output, formula)
File.write(cask_output, cask)
