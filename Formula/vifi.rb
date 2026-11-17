class Vifi < Formula
  include Language::Python::Virtualenv

  desc "Universal voice layer for AI coding agents, MCP, and macOS"
  homepage "https://voicefi.org"
  url "https://github.com/atxatlarge-code/voicefi/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "2ee0fff329aa61b58ffd43e932fbe503dbb72f0faa59882ae06f95c9f5f23e94"
  license "MIT"
  head "https://github.com/atxatlarge-code/voicefi.git", branch: "main"

  depends_on "ffmpeg"
  depends_on "libsndfile"
  depends_on "portaudio"
  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    system "python3.12", "-m", "pip", "--python=#{libexec}/bin/python", "install", "--no-cache-dir", buildpath

    bin.install_symlink libexec/"bin/vifi" => "vifi"
    bin.install_symlink libexec/"bin/voicefi" => "voicefi"
    bin.install_symlink libexec/"bin/vg" => "vg"
    bin.install_symlink libexec/"bin/voicegency" => "voicegency"
  end

  def caveats
    <<~EOS
      VoiceFi (vifi) has been installed!

      To connect AI Agent lifecycle hooks (Antigravity & Claude Code):
        vifi setup

      To enable persistent Menu Bar & Dynamic Island HUD:
        vifi autostart

      To test speech audio:
        vifi voice test

      To open the interactive web control panel:
        vifi panel
    EOS
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/vifi --version")
    assert_match "0.1.0", shell_output("#{bin}/voicefi --version")
  end
end
