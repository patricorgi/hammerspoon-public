local home = os.getenv("HOME")
local scope = {}
scope.appFolders = {
    "/Applications",
    home .. "/Applications",
    "/System/Applications",
    "/System/Applications/Utilities",
}
local folders = {
    home,
    home .. "/Library/Mobile Documents/com~apple~CloudDocs",
}
local function searchablePath(path)
    local library = home .. "/Library/"
    local cloud = folders[2]
    if path:sub(1, #library) == library and path ~= cloud
        and path:sub(1, #cloud + 1) ~= cloud .. "/" then return false end
    for part in path:gmatch("[^/]+") do
        if part:sub(1, 1) == "." or part:lower():match("%.app$") then return false end
    end
    return true
end
scope.searchablePath = searchablePath
local extensions = {
    "pdf", "doc", "docx", "docm", "xls", "xlsx", "xlsm", "ppt", "pptx", "pptm",
    "pages", "numbers", "key", "odt", "ods", "odp", "rtf", "rtfd", "epub",
}
local predicates = {}
for _, extension in ipairs(extensions) do
    predicates[#predicates + 1] = 'kMDItemFSName == "*.' .. extension .. '"c'
end
scope.documents = "(" .. table.concat(predicates, " || ") .. ")"

function scope.spotlightArguments(predicate, includeFolders)
    local args = { "-0" }
    for _, folder in ipairs(folders) do
        if hs.fs.attributes(folder, "mode") == "directory" then
            args[#args + 1] = "-onlyin"
            args[#args + 1] = folder
        end
    end
    if #args == 1 then return end
    local types = scope.documents
    if includeFolders then types = '(' .. types .. ' || kMDItemContentType == "public.folder")' end
    args[#args + 1] = predicate and (types .. " && (" .. predicate .. ")") or types
    return args
end

return scope
