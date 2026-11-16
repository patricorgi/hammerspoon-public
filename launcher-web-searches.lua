-- Type a keyword followed by a space and the search terms.
return {
    { keyword = "g", name = "Google", url = "https://www.google.com/search?q={query}", fallback = true },
    { keyword = "ddg", name = "DuckDuckGo", url = "https://duckduckgo.com/?q={query}", fallback = true },
    { keyword = "yt", name = "YouTube", url = "https://www.youtube.com/results?search_query={query}", fallback = true },
    { keyword = "maps", name = "Google Maps", url = "https://www.google.com/maps/search/?api=1&query={query}", fallback = true },
    { keyword = "img", name = "Google Images", url = "https://www.google.com/search?tbm=isch&q={query}", fallback = true },
}
