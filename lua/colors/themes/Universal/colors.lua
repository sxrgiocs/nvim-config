local function load_palette()
    local filepath = os.getenv("HOME") .. "/.config/theme/colors.conf"
    local f = io.open(filepath, "r")
    local palette = {}

    if not f then return palette end

    for line in f:lines() do
        -- Extract "key #hex"
        local key, hex = string.match(line, "^([%w_]+)%s+(#[a-fA-F0-9]+)")
        if key and hex then
            palette[key] = hex
        end
    end
    f:close()

    return palette
end

local p = load_palette()

-- Map the raw 16 colors to your semantic Neovim names
-- Map the raw palette to your semantic Neovim names
return {
    white       = p.foreground,
    background  = p.background,
    background2 = p.background2,

    -- Your explicit black overrides, falling back to standard if needed
    black       = p.black or p.color0,
    black2      = p.black2 or p.color8,
    black3      = p.black3,

    -- The standard 16 Kitty colors
    red         = p.color1,
    red2        = p.color9,

    green       = p.color2,
    green2      = p.color10,

    yellow      = p.color3,
    yellow2     = p.color11,

    blue        = p.color4,
    blue2       = p.color12,

    magenta     = p.color5,
    magenta2    = p.color13,

    cyan        = p.color6,
    cyan2       = p.color14,

    -- The extended Neovim colors
    pink        = p.pink,
    pink2       = p.pink2,
    violet      = p.violet,
    violet2     = p.violet2,
    orange      = p.orange,
    orange2     = p.orange2,
    gray        = p.color7,
    gray2       = p.gray2,
}
