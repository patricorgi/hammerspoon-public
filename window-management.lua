local spaces = require("hs.spaces")
local ctrlAlt = { "ctrl", "alt" }
local shiftCtrlAlt = { "shift", "ctrl", "alt" }

local function bind(modifiers, key, action)
    hs.hotkey.bind(modifiers, key, function()
        local window = hs.window.focusedWindow()
        if window and window:isStandard() and not window:isFullScreen() then
            local screen = window:screen()
            if screen then action(window, screen) end
        end
    end)
end

-- Anchor the window to the same corner as the screen rectangle.
local function layout(width, height, corner, full, dx, dy, dw, dh)
    return function(window, screen)
        local area = full and screen:fullFrame() or screen:frame()
        local w = area.w * width + (dw or 0)
        local h = area.h * height + (dh or 0)
        local x = area.x + (corner % 2 == 0 and area.w - w or 0) + (dx or 0)
        local y = area.y + (corner > 2 and area.h - h or 0) + (dy or 0)
        window:setFrame({ x = x, y = y, w = w, h = h }, 0)
    end
end

local function horizontalThirds(start, width)
    return function(window, screen)
        local area = screen:frame()
        window:setFrame({
            x = area.x + area.w * start / 3,
            y = area.y,
            w = area.w * width / 3,
            h = area.h,
        }, 0)
    end
end

local function center(window, screen)
    window:centerOnScreen(screen, false, 0)
end

local function moveSpace(direction)
    return function(window, screen)
        local desktops = spaces.spacesForScreen(screen)
        local membership = spaces.windowSpaces(window)
        if not desktops or not membership then return end
        local current = membership[1]
        for index, id in ipairs(desktops) do
            if id == current then
                local target = index + direction
                while desktops[target] do
                    local destination = desktops[target]
                    if spaces.spaceType(destination) == "user" then
                        local ok, err = spaces.moveWindowToSpace(window, destination)
                        if not ok then hs.alert.show(err or "Could not move window to desktop") end
                        return
                    end
                    target = target + direction
                end
                return
            end
        end
    end
end

bind(ctrlAlt, 0, layout(0.5, 1, 1, true))  -- A
bind(shiftCtrlAlt, 0, layout(0.5, 1, 1, true))
bind(ctrlAlt, 2, layout(0.5, 1, 2, true))  -- D
bind(shiftCtrlAlt, 2, layout(0.5, 1, 2, true))
bind({ "alt", "cmd" }, 48, function(window, screen)
    local destination = screen:next()
    if destination:id() ~= screen:id() then
        window:moveToScreen(destination, false, false, 0)
    end
end)
bind(ctrlAlt, 36, function(window, screen)
    local area = screen:frame()
    window:setFrame({ x = area.x + area.w * 0.05, y = area.y + area.h * 0.05,
        w = area.w * 0.9, h = area.h * 0.9 }, 0)
end)
bind(ctrlAlt, 7, center)  -- X
bind(ctrlAlt, 3, function(window, screen) window:setFrame(screen:frame(), 0) end)  -- F
bind(shiftCtrlAlt, 3, layout(1, 1, 1, false, 0, 5, -10, -10))
bind(ctrlAlt, 1, layout(1, 0.5, 3, false, 0, -5, -5, -7.5))  -- S
bind(ctrlAlt, 13, layout(1, 0.5, 1, false, 0, 5, -5, -7.5))  -- W

-- U/I/J/K anchor to top-left, top-right, bottom-left, bottom-right.
for corner, key in ipairs({ 32, 34, 38, 40 }) do
    bind(ctrlAlt, key, layout(0.5, 0.5, corner, false))
    bind(shiftCtrlAlt, key, layout(0.9, 0.9, corner, false))
end
bind(ctrlAlt, 48, moveSpace(1))
bind(shiftCtrlAlt, 48, moveSpace(-1))

bind(ctrlAlt, 43, horizontalThirds(0, 1))  -- Comma
bind(shiftCtrlAlt, 43, horizontalThirds(0, 2))
bind(ctrlAlt, 46, horizontalThirds(1, 1))  -- M
bind(shiftCtrlAlt, 46, function(window, screen)
    horizontalThirds(1, 2)(window, screen)
    center(window, screen)
end)
bind(ctrlAlt, 47, horizontalThirds(2, 1))  -- Period
bind(shiftCtrlAlt, 47, horizontalThirds(1, 2))
