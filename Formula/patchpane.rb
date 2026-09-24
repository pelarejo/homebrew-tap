class Patchpane < Formula
  desc "Local, self-contained HTML viewer for Git diffs"
  homepage "https://github.com/pelarejo/Patchpane"
  url "https://github.com/pelarejo/Patchpane/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "2c71983e03d7f112225b6c7c1c62c9fdb56c48ff0291178ea1736bb8983fda2c"
  license "MIT"

  bottle do
    root_url "https://github.com/pelarejo/homebrew-tap/releases/download/patchpane-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "32a6f4d5a807d70e012cbc73b35f90eb458973cecb0e185dc2d53509faa63f11"
    sha256 cellar: :any,                 x86_64_linux: "b0a0d5f82e35c8877ad11e49e92fceee191c13da4806055e9b508f3bc65cba38"
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
