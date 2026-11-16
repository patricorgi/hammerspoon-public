-- Option + key opens or focuses the application with this bundle ID.
local apps = {
    ["1"] = { name = "Kitty", bundleID = "net.kovidgoyal.kitty" },
    ["2"] = { name = "Safari", bundleID = "com.apple.Safari" },
}

for key, app in pairs(apps) do
    hs.hotkey.bind({ "alt" }, key, function()
        if not hs.application.launchOrFocusByBundleID(app.bundleID) then
            hs.alert.show("Could not open " .. app.name)
        end
    end)
end
