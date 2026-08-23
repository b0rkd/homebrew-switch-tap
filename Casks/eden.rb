cask "eden" do
  version "0.2.1"
  sha256 "40575fc79a61550fbb9e332cbae94ccd20f5de20ff61b4b60fe1d42f2525c0b5"

  url "https://git.eden-emu.dev/eden-emu/eden/releases/download/v#{version}/Eden-macOS-v#{version}.dmg",
      verified: "git.eden-emu.dev/eden-emu/eden/"
  name "Eden"
  desc "Nintendo Switch emulator"
  homepage "https://eden-emu.dev/"

  livecheck do
    url "https://git.eden-emu.dev/api/v1/repos/eden-emu/eden/releases?limit=1"
    strategy :json do |json|
      json.map { |release| release["tag_name"]&.delete_prefix("v") }
    end
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "eden.app"

  zap trash: [
    "~/Library/Application Support/eden",
    "~/Library/Preferences/com.yuzu-emu.yuzu.plist",
    "~/Library/Saved Application State/com.yuzu-emu.yuzu.savedState",
  ]

  caveats do
    <<~EOS
      Eden is not notarized. macOS blocks the first launch.
      Open System Settings -> Privacy & Security and click "Open Anyway".
      macOS support is experimental. Expect graphical glitches and crashes.
    EOS
  end
end
