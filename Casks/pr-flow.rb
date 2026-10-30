cask "pr-flow" do
  version "0.1.0"
  sha256 "97ccd83ce2e12c17cd20d0f0141953f4729f367018246bc072ec60d2c43991f5"

  url "https://github.com/DeltaB-Lab/pr-flow/releases/download/v#{version}/PRFlow-v#{version}.zip"
  name "PRFlow"
  desc "GitHub pull requests in your menu bar"
  homepage "https://github.com/DeltaB-Lab/pr-flow"

  depends_on macos: ">= :ventura"

  app "PRFlow.app"

  postflight do
    # The app is ad-hoc signed, so strip the quarantine attribute
    # to avoid Gatekeeper's "damaged app" dialog on first launch.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/PRFlow.app"],
                   must_succeed: false
  end

  caveats <<~EOS
    PRFlow requires the GitHub CLI:
      brew install gh && gh auth login
  EOS
end
