cg.addPath('articles', '.')

cg.addFile('index.html.cgt')
cg.addFile('style.css.cgt')

local function getArticles()
    local list = {}

    for file in io.popen('ls articles/'):lines() do
        if file:sub(-4) == ".lua" then
            local article = loadfile("articles/" .. file)()
            if article then
                article.file = file:gsub("%.lua$", ".html")
                table.insert(list, article)
            end
        end
    end

    return list
end

cg.opt.articles = getArticles();
cg.opt.style = require('style')
cg.opt.doctype = "<!doctype html>"
cg.opt.header_links = [[
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Share+Tech&display=swap" rel="stylesheet">
]]
