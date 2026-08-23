# Dev command surface.

tap_dir := shell('brew --repository') / "Library/Taps/b0rkd/homebrew-switch-tap"

default:
    @just --list

[doc('Point the casks at the newest upstream releases')]
bump:
    ./bin/bump-casks

# `brew audit` and `brew install` refuse plain paths, so expose this working
# tree to Homebrew as a real tap.
[doc('Register this working tree as the b0rkd/switch-tap tap')]
tap-local:
    mkdir -p "$(dirname '{{ tap_dir }}')"
    ln -sfn "$(pwd)" '{{ tap_dir }}'

[doc('Lint the casks and verify their download URLs')]
audit: tap-local
    brew style ./Casks
    brew audit --cask --online b0rkd/switch-tap/eden b0rkd/switch-tap/ryubing 'b0rkd/switch-tap/ryubing@canary'

[doc('Install both casks from this working tree')]
install: tap-local
    brew install --cask b0rkd/switch-tap/eden b0rkd/switch-tap/ryubing
