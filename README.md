# homebrew-switch-tap

A Homebrew tap for Nintendo Switch emulators on macOS. Each cask tracks the
newest release from the official upstream repository.

| Cask | Upstream | Architecture |
| --- | --- | --- |
| `eden` | [git.eden-emu.dev/eden-emu/eden](https://git.eden-emu.dev/eden-emu/eden/releases) | Apple Silicon only |
| `ryubing` | [git.ryujinx.app/projects/Ryubing](https://git.ryujinx.app/projects/Ryubing/releases) | Universal |
| `ryubing@canary` | [git.ryujinx.app/Ryubing/Canary](https://git.ryujinx.app/Ryubing/Canary/releases) | Universal |

## Installation

```bash
brew tap b0rkd/switch-tap
brew install --cask eden
brew install --cask ryubing
```

Ryubing has two release channels. The stable channel is `ryubing`. The
canary channel is `ryubing@canary`, built from every upstream commit. Both
install `Ryujinx.app`, so you can only have one of them at a time.

## Gatekeeper

Neither app is notarized by Apple. macOS blocks the first launch. To allow the
app, open System Settings, go to Privacy & Security, then click "Open Anyway".

## Updates

`bin/bump-casks` reads the newest release from each upstream API. It rewrites
the version and the checksum in the cask. A daily GitHub Actions workflow runs
the script and commits the result.

```bash
just bump     # sync the casks with upstream
just audit    # lint the casks and verify the download URLs
just install  # install both casks from this working tree
```
