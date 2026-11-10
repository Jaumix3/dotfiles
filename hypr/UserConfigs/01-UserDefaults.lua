-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- User default apps, used by UserKeybinds.lua.
-- Lua twin of 01-UserDefaults.conf

return {
    edit = os.getenv("EDITOR") or "nano",
    term = "kitty",          -- Terminal
    files = "nautilus",      -- File manager
    -- Default search engine for the Rofi search (scripts/RofiSearch.sh)
    Search_Engine = "https://www.google.com/search?q={}",
}
