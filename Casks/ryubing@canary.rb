cask "ryubing@canary" do
  version "1.3.341"
  sha256 "e84d5518b207c93a15a2fa94fe80c21e2efc236edc6ee9d82d9b8ac93153af39"

  url "https://git.ryujinx.app/Ryubing/Canary/releases/download/#{version}/ryujinx-canary-#{version}-macos_universal.app.tar.gz",
      verified: "git.ryujinx.app/Ryubing/Canary/"
  name "Ryubing Canary"
  name "Ryujinx Canary"
  desc "Nintendo Switch emulator, per-commit builds of the Ryubing continuation"
  homepage "https://git.ryujinx.app/Ryubing/Canary"

  livecheck do
    url "https://git.ryujinx.app/api/v1/repos/Ryubing/Canary/releases?limit=1"
    strategy :json do |json|
      json.map { |release| release["tag_name"] }
    end
  end

  # Both channels unpack to Ryujinx.app, so they cannot share /Applications.
  conflicts_with cask: "b0rkd/switch-tap/ryubing"
  depends_on macos: :monterey

  app "Ryujinx.app"

  zap trash: [
    "~/Library/Application Support/Ryujinx",
    "~/Library/Preferences/org.ryujinx.Ryujinx.plist",
    "~/Library/Saved Application State/org.ryujinx.Ryujinx.savedState",
  ]

  caveats do
    <<~EOS
      Ryubing Canary is not notarized. macOS blocks the first launch.
      Open System Settings -> Privacy & Security and click "Open Anyway".
      Canary builds come from every upstream commit and are less tested
      than the stable ryubing cask.
    EOS
  end
end
