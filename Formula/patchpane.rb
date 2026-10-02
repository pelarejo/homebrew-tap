class Patchpane < Formula
  desc "Local, self-contained HTML viewer for Git diffs"
  homepage "https://github.com/pelarejo/Patchpane"
  url "https://github.com/pelarejo/Patchpane/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "202f9615e2dca7ac16b8488f0375da819c06bb3c4532af7a727d370150b3442c"
  license "MIT"
  head "https://github.com/pelarejo/Patchpane.git", branch: "main"

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
