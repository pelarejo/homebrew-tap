class Patchpane < Formula
  desc "Local, self-contained HTML viewer for Git diffs"
  homepage "https://github.com/pelarejo/Patchpane"
  url "https://github.com/pelarejo/Patchpane/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "202f9615e2dca7ac16b8488f0375da819c06bb3c4532af7a727d370150b3442c"
  license "MIT"
  head "https://github.com/pelarejo/Patchpane.git", branch: "main"

  bottle do
    root_url "https://github.com/pelarejo/homebrew-tap/releases/download/patchpane-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c84cc3fed56d4651679f7a9d1f139e9a47a5e758a872654cc01b833e58776ea7"
    sha256 cellar: :any,                 x86_64_linux: "9c91eba8c8eee7f45d6731f2a64470eb57523849fa2cd02bd6631281fdf6baa4"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "git", "init"
    (testpath/"example.txt").write("Hello from Patchpane\n")
    system "git", "add", "example.txt"
    system bin/"patchpane", "--staged", "--no-open", "-o", "review.html"
    assert_match "<!doctype html>", (testpath/"review.html").read
  end
end
