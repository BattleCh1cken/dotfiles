local ok, bufferline = pcall(require, "bufferline")

if not ok then
    print("e") return 
end

-- local colors = require("theme").colors


bufferline.setup {}
