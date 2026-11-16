local launcher = require("search-launcher")
require("app-launchers")

-- Uncomment to enable window-management shortcuts independently.
-- require("window-management")

-- Uncomment to register optional PDF and photo actions.
-- require("launcher-file-conversions")

local key = "glassLauncherPublicProcessID"
local pid = hs.application.get(hs.processInfo.bundleID):pid()
if hs.settings.get(key) == pid then
    hs.notify.new({ title = "Hammerspoon", informativeText = "Configuration reloaded" }):send()
end
hs.settings.set(key, pid)

launcher.prewarm()
