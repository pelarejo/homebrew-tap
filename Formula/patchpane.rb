class Patchpane < Formula
  desc "Local, self-contained HTML viewer for Git diffs"
  homepage "https://github.com/pelarejo/Patchpane"
  url "https://github.com/pelarejo/Patchpane/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "2c71983e03d7f112225b6c7c1c62c9fdb56c48ff0291178ea1736bb8983fda2c"
  license "MIT"
  revision 1
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
