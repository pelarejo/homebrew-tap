class Patchpane < Formula
  desc "Local, self-contained HTML viewer for Git diffs"
  homepage "https://github.com/pelarejo/Patchpane"
  url "https://github.com/pelarejo/Patchpane/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "2c71983e03d7f112225b6c7c1c62c9fdb56c48ff0291178ea1736bb8983fda2c"
  license "MIT"
  revision 1
  head "https://github.com/pelarejo/Patchpane.git", branch: "main"

  bottle do
    root_url "https://github.com/pelarejo/homebrew-tap/releases/download/patchpane-0.1.2_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5bdc2c5ee68cbc57aeafd21918c51dd33e8bf6c8c3488637bb2b76fbe947c2cc"
    sha256 cellar: :any,                 x86_64_linux: "fc4faf030639cdc83386d9a6a7ab70cf9c735f04a65e1c5cd1107f11ea5138be"
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
