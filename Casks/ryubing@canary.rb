cask "ryubing@canary" do
  version "1.3.350"
  sha256 "ce24012f6460cdaa2676a6986b13b4c8d9de497ee8793cb071fa1a7623f1f27c"

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
