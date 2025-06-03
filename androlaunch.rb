cask "androlaunch" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/alex1115alex/AndroLaunch/releases/download/v#{version}/AndroLaunch.dmg"
  name "AndroLaunch"
  desc "Android Device Management Suite for macOS"
  homepage "https://github.com/alex1115alex/AndroLaunch"

  depends_on macos: ">= :ventura"
  depends_on formula: "android-platform-tools"

  app "AndroLaunch.app"

  uninstall quit: "com.androlaunch.AndroLaunch"

  zap trash: [
    "~/Library/Preferences/com.androlaunch.AndroLaunch.plist",
    "~/Library/Application Support/AndroLaunch",
  ]
end