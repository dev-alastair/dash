# dash-wally

A collection of core utilities expanding the capabilities of Lua in Roblox, tweaked for intellisense support.

[Read the docs](https://roblox.github.io/dash-internal/)

## Changes from [roblox/dash](https://github.com/roblox/dash)

- intellisense support
- function documentation appears in Signature Help pop-ups
- republished as a [wally](wally.run) package, for easy integration with Roblox projects

## Install

dash-wally can be installed using wally. For example:

```toml
[dependencies]
dash = "dev-alastair/dash@1.1.1"
```

## Details

### Run tests

_(requires `FFLagEnableLoadModule`, see: [issue](https://github.com/jsdotlua/jest-lua/issues/6), [more info](https://devforum.roblox.com/t/fast-flags-clientappsettingsjson-folder-locations-for-most-os-eg-windows-macos-android-and-ios/3180597))_ 

```bash
rojo build .\suites\tests.project.json --output .\suites\tests.rbxl
run-in-roblox --place .\suites\tests.rbxl --script .\suites\run-tests.lua
rmdir .\suites\tests.rbxl 
```
