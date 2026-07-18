#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "uri"

version, url, sha256, output = ARGV
abort "usage: render-formula.rb VERSION URL SHA256 OUTPUT" unless output
abort "invalid semantic version" unless version.match?(/\A\d+\.\d+\.\d+\z/)
abort "invalid SHA-256" unless sha256.match?(/\A[0-9a-f]{64}\z/)

uri = URI.parse(url)
expected_path = "/codecarton/swiftpkg/releases/download/v#{version}/swiftpkg-#{version}-universal.tar.gz"
unless uri.scheme == "https" && uri.host == "github.com" && uri.path == expected_path && !uri.query && !uri.fragment
  abort "URL is not the immutable swiftpkg release archive for version #{version}"
end

formula = <<~RUBY
  class Swiftpkg < Formula
    desc "Build macOS installer packages from project directories"
    homepage "https://github.com/codecarton/swiftpkg"
    url "#{url}"
    sha256 "#{sha256}"
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

FileUtils.mkdir_p(File.dirname(output))
File.write(output, formula)
