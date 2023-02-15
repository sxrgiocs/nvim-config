local present, icons = pcall(require, "nvim-web-devicons")
if not present then
    return
end

local global_theme = "colors.themes/" .. require("colors.theme").ui.theme
local colors = require(global_theme)

icons.setup {
    override = {
        html = {
            icon = "",
            color = colors.orange2,
            name = "html"
        },
        css = {
            icon = "",
            color = colors.blue,
            name = "css"
        },
        js = {
            icon = "",
            color = colors.yellow,
            name = "js"
        },
        ts = {
            icon = "ﯤ",
            color = colors.blue2,
            name = "ts"
        },
        kt = {
            icon = "",
            color = colors.orange,
            name = "kt"
        },
        png = {
            icon = "",
            color = colors.purple,
            name = "png"
        },
        jpg = {
            icon = "",
            color = colors.purple,
            name = "jpg"
        },
        jpeg = {
            icon = "",
            color = colors.purple,
            name = "jpeg"
        },
        mp3 = {
            icon = "",
            color = colors.white,
            name = "mp3"
        },
        mp4 = {
            icon = "",
            color = colors.white,
            name = "mp4"
        },
        out = {
            icon = "",
            color = colors.white,
            name = "out"
        },
        Dockerfile = {
            icon = "",
            color = colors.cyan,
            name = "Dockerfile"
        },
        rb = {
            icon = "",
            color = colors.red,
            name = "rb"
        },
        vue = {
            icon = "﵂",
            color = colors.green,
            name = "vue"
        },
        py = {
            icon = "",
            color = colors.green2,
            name = "py"
        },
        toml = {
            icon = "",
            color = colors.gray2,
            name = "toml"
        },
        lock = {
            icon = "",
            color = colors.red,
            name = "lock"
        },
        zip = {
            icon = "",
            color = colors.yellow2,
            name = "zip"
        },
        xz = {
            icon = "",
            color = colors.yellow2,
            name = "xz"
        },
        deb = {
            icon = "",
            color = colors.pink,
            name = "deb"
        },
        rpm = {
            icon = "",
            color = colors.black,
            name = "rpm"
        },
        lua = {
            icon = "",
            color = colors.blue,
            name = "lua"
        },
        tex = {
            icon = "ﭨ",
            color = colors.gray2,
            name = "LaTeX"
        }
    }
}
