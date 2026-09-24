class Patchpane < Formula
  desc "Local, self-contained HTML viewer for Git diffs"
  homepage "https://github.com/pelarejo/Patchpane"
  url "https://github.com/pelarejo/Patchpane/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "eb89c0cc54b8a8555ef92ff4be1328c8501ba0b23293050e4417ddade9ab6d50"
  license "MIT"
  head "https://github.com/pelarejo/Patchpane.git", branch: "main"

  bottle do
    root_url "https://github.com/pelarejo/homebrew-tap/releases/download/patchpane-0.1.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f7ab0c5dd7ced20cb9e5eae3b28e867af21706ce22195c448a15c7283b8218a5"
    sha256 cellar: :any,                 x86_64_linux: "7dc4d830e2e6c9adfa8ccfc14eaaf864cadabe8c335a454cf3a13378cacf3c13"
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
