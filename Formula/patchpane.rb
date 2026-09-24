class Patchpane < Formula
  desc "Local, self-contained HTML viewer for Git diffs"
  homepage "https://github.com/pelarejo/Patchpane"
  url "https://github.com/pelarejo/Patchpane/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a0ae4c601476a176b975e4e76aff789655ec06faebab4e527944609493b88ccd"
  license "MIT"

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
