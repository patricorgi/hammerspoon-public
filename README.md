# Hammerspoon Launcher with Liquid Glass

A macOS launcher for Hammerspoon with app and file search, clipboard history, and system shortcuts.

### Dark mode

https://github.com/user-attachments/assets/d9e80d5c-7342-40ad-80f5-38b6a24c958c

### Light mode

https://github.com/user-attachments/assets/3c282375-8b53-4cfb-92ad-29b69b39546c

[Background footage](https://youtu.be/sEH3pOhj0xs?t=250)

## Install

Requires macOS 26+, Hammerspoon, and Xcode or Command Line Tools with the macOS 26 SDK.

1. Clone and build.

   ```sh
   git clone https://github.com/patricorgi/hammerspoon-public.git
   cd hammerspoon-public
   ./build.sh
   ```
2. Copy the Lua files, the `fallback-icons/` directory, `GlassLauncher.app`, and `launcher-define` to `~/.hammerspoon/`. If you already use Hammerspoon, back up your config and merge `init.lua`.
3. Grant Hammerspoon Accessibility access and reload its config. Reassign Spotlight’s shortcut if it conflicts with `⌘Space`.

## Use

| Shortcut | Action |
| --- | --- |
| `⌘Space` | Search apps, documents, folders, and System Settings |
| `⌘⇧V` | Clipboard history. Press `↩` to paste or `⌘↩` to copy |
| `Ctrl` on a result or `⌥S` on a selection | Open Universal Actions |
| `⇧` on a file or `⌘↩` | Quick Look or reveal in Finder |

Try `~` to browse files, `storage` for disk usage, `eject` for external drives, `caffeine` to stay awake, or `reload` to reload Hammerspoon. The launcher also supports calculations, dictionaries, and web searches.

`⌥1` opens Kitty and `⌥2` opens Safari. Edit the shortcut list in [app-launchers.lua](app-launchers.lua).

## Optional features

- **Universal Actions** starts empty. In your config, register handlers with `require("universal-actions").register(kind, definition)`.
- **PDF and photo actions** require Poppler and ExifTool. Enable `launcher-file-conversions` in [init.lua](init.lua).
- **Window management** is enabled separately in [init.lua](init.lua).

Clipboard history stays on the Mac. Translation sends the query to Google, and currency conversion uses Frankfurter.
