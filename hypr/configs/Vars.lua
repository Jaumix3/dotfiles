-- Shared paths and default apps used by the Lua config.
-- Equivalent of the `$scriptsDir`, `$UserScripts`, ... variables of the .conf files.

local home = os.getenv("HOME")
local hypr = home .. "/.config/hypr"

return {
    mainMod = "SUPER",
    hypr = hypr,
    scriptsDir = hypr .. "/scripts",
    UserScripts = hypr .. "/UserScripts",
    UserConfigs = hypr .. "/UserConfigs",
}
