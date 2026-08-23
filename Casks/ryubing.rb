cask "ryubing" do
  version "1.3.3"
  sha256 "e4818bb84c98e0d3120691821e90772099e46101273d3f145ffdb10eee2c0dbb"

  url "https://git.ryujinx.app/projects/Ryubing/releases/download/#{version}/ryujinx-#{version}-macos_universal.app.tar.gz",
      verified: "git.ryujinx.app/projects/Ryubing/"
  name "Ryubing"
  name "Ryujinx"
  desc "Nintendo Switch emulator, community continuation of Ryujinx"
  homepage "https://git.ryujinx.app/projects/Ryubing"

  livecheck do
    url "https://git.ryujinx.app/api/v1/repos/projects/Ryubing/releases?limit=1"
    strategy :json do |json|
      json.map { |release| release["tag_name"] }
    end
  end

  # Both channels unpack to Ryujinx.app, so they cannot share /Applications.
  conflicts_with cask: "b0rkd/switch-tap/ryubing@canary"
  depends_on macos: :monterey

  app "Ryujinx.app"

  zap trash: [
    "~/Library/Application Support/Ryujinx",
    "~/Library/Preferences/org.ryujinx.Ryujinx.plist",
    "~/Library/Saved Application State/org.ryujinx.Ryujinx.savedState",
  ]

  caveats do
    <<~EOS
      Ryubing is not notarized. macOS blocks the first launch.
      Open System Settings -> Privacy & Security and click "Open Anyway".
    EOS
  end
end
