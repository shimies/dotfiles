--==--==--==--==--==--==--==--==--==--==--==--==--
-- Key-mappings
-- * See:
--   * :help vim.keymap
--   * :help :map-modes
--   * :help default-mappings
--==--==--==--==--==--==--==--==--==--==--==--==--
local keymap = vim.keymap

keymap.set("n", "Y", "y$")

-- Enable `*' and `#' search in visual mode; see `:help /magic' for details on \V
keymap.set("x", "*", [["vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', "g")<CR><CR>]], { silent = false })
keymap.set("x", "#", [["vy?\V<C-r>=substitute(escape(@v, '\?'), "\n", '\\n', "g")<CR><CR>]], { silent = false })

-- Disable searching or its highlight
keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })
keymap.set("n", "<Esc><CR>", ':let @/ = ""<CR>', { silent = true }) -- overwrite `/' register (see `:help :let-@')

-- Move one line for wrapped lines
keymap.set({ "n", "x", "o" }, "j", "gj")
keymap.set({ "n", "x", "o" }, "gj", "j")
keymap.set({ "n", "x", "o" }, "k", "gk")
keymap.set({ "n", "x", "o" }, "gk", "k")

-- Swap : for ; to enter command-mode
keymap.set({ "n", "x" }, ":", ";")
keymap.set({ "n", "x" }, ";", ":")

-- Redraw to centralize the next search matching line
keymap.set("n", "n", "nzz")
keymap.set("n", "N", "Nzz")
keymap.set("n", "*", "*zz")
keymap.set("n", "#", "#zz")
keymap.set("n", "g*", "g*zz")
keymap.set("n", "g#", "g#zz")

-- Use arrow-keys to control window
keymap.set("n", "<Left>", "<C-w>h")
keymap.set("n", "<Down>", "<C-w>j")
keymap.set("n", "<Up>", "<C-w>k")
keymap.set("n", "<Right>", "<C-w>l")
keymap.set("n", "<S-Left>", "<C-w><")
keymap.set("n", "<S-Right>", "<C-w>>")
keymap.set("n", "<S-Up>", "<C-w>+")
keymap.set("n", "<S-Down>", "<C-w>-")

-- Make easy-to-mistype keys unavailable
for zkey, _ in pairs { ZZ = "eqv. :x", ZQ = "eqv. :q!" } do
    keymap.set("n", zkey, "<Nop>")
end

-- Set of frequently used commands for convenience
keymap.set("n", "cd", function()
    return string.format(":lcd %s<CR>", vim.fn.expand("%:h"))
end, { expr = true })
keymap.set("n", "<Space>g", function()
    return string.format(":vimgrep /\\<%s\\>/gj **/*.%s", vim.fn.expand("<cword>"), vim.fn.expand("%:e"))
end, { expr = true })
keymap.set("n", "<Space>G", function()
    return string.format(":silent grep! %s **/*.%s", vim.fn.expand("<cword>"), vim.fn.expand("%:e"))
end, { expr = true })

-- Move action in insert-mode
keymap.set("i", "<C-a>", function()
    local at_indents = vim.fn.search([[^\s*\%#]], "bcn") > 0
    return (at_indents and "<C-o>0") or "<C-o>^"
end, { expr = true })
keymap.set("i", "<C-e>", "<C-o>$")
keymap.set("i", "<C-f>", "<Right>")
keymap.set("i", "<C-b>", "<Left>")

-- Escape automatically a letter of backslash or question
keymap.set("c", "/", function() return vim.fn.getcmdtype() == "/" and [[\/]] or [[/]] end, { expr = true })
keymap.set("c", "?", function() return vim.fn.getcmdtype() == "?" and [[\?]] or [[?]] end, { expr = true })

-- [buffer] control shortcut keys
keymap.set("n", "[buffer]", "<Nop>")
keymap.set("n", "<Space>b", "[buffer]", { remap = true })
keymap.set("n", "[buffer]", ":buffer<Space>", { silent = true })
keymap.set("n", "[buffer]b", ":buffers t<CR>", { silent = true })
keymap.set("n", "[buffer]B", ":buffers! t<CR>", { silent = true })
keymap.set("n", "[buffer]n", ":bnext<CR>", { silent = true })
keymap.set("n", "[buffer]p", ":bprevious<CR>", { silent = true })
keymap.set("n", "[buffer]d", ":Bdelete<CR>", { silent = true })
keymap.set("n", "[buffer]D", ":bdelete!<CR>", { silent = true })
keymap.set("n", "[buffer]w", ":Bwipeout<CR>", { silent = true })
keymap.set("n", "[buffer]W", ":bwipeout!<CR>", { silent = true })

-- [quickfix] control shortcut keys
keymap.set("n", "[quickfix]", "<Nop>")
keymap.set("n", "<Space>q", "[quickfix]", { remap = true })
keymap.set("n", "[quickfix]q", ":copen<CR>", { silent = true })
keymap.set("n", "[quickfix]n", ":cnext<CR>", { silent = true })
keymap.set("n", "[quickfix]p", ":cprevious<CR>", { silent = true })
keymap.set("n", "[quickfix]g", ":cfirst<CR>", { silent = true })
keymap.set("n", "[quickfix]G", ":clast!<CR>", { silent = true })

-- [switch] of option control shortcut keys
keymap.set("n", "[switch]", "<Nop>")
keymap.set("n", "<Space>s", "[switch]", { remap = true })
keymap.set("n", "[switch]s", ":setlocal spell!<CR>:setlocal spell?<CR>", { silent = true })
keymap.set("n", "[switch]l", ":setlocal list!<CR>:setlocal list?<CR>", { silent = true })
keymap.set("n", "[switch]t", ":setlocal expandtab!<CR>:setlocal expandtab?<CR>", { silent = true })
keymap.set("n", "[switch]w", ":setlocal wrap!<CR>:setlocal wrap?<CR>", { silent = true })
keymap.set("n", "[switch]n", ":setlocal number!<CR>:setlocal number?<CR>", { silent = true })
keymap.set("n", "[switch]r", ":setlocal relativenumber!<CR>:setlocal relativenumber?<CR>", { silent = true })
