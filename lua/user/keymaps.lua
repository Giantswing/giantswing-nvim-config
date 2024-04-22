-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<C-i>", "<C-i>", opts)
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " " vim.g.maplocalleader = " "

-- keymap("n", "<C-i>", "<C-i>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts) --m is Alt, S is shift, C is control
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)

-- Tree toggle
keymap("n", "<leader><tab>", ":NvimTreeToggle<CR>", opts)


-- Keybinding for pounce
keymap("n", "+", "<cmd>Pounce<CR>", opts)
keymap("n", "z", "<cmd>Pounce<CR>", opts)
-- keymap("n", "<leader>j", "<cmd>Pounce<CR>", opts)

-- Use '  and a letter to jump to a mark
-- keymap("n", "<leader>m", "m]", opts)

-- Delete multiple spaces

--Fix paste in insert mode
keymap("i", "<C-v>", "<C-r>*", opts)

--Paste second register
keymap("n", "<leader>p", "\"2p", opts)

----------------------------------To access old registers you can use :reg to see them
----------------------------------and then use "2p to paste the second register for example
-- Restore Control Z functionality to undo

keymap("i", "<C-z>", "<Esc>ui")
keymap("n", "<C-z>", "ui")

-- Maximize keymap
keymap("n", "<leader>we", "<C-w>|<C-w>_", opts)
keymap("n", "<leader>wr", "<C-w>=", opts)

-- Focus region narrow and maximize
keymap({"v", "x"}, "<leader>wg", "<Plug>NrrwrgnDo<CR><C-w>|<C-w>_", opts)


-- Folds
vim.keymap.set('n', '<leader>z', 'za')

-- Fast vertical split
keymap("n", "<leader>v", ":vsplit<CR>", opts)
-- Fast horizontal split
keymap("n", "<leader>x", ":split<CR>", opts)

-- Sort
keymap({ "x", "v" }, "<leader>S", ":Sort<CR>", opts)
keymap({ "n", "v", "x" }, "<leader>t", ":TailwindSort<CR>", opts)

-- Launch fzf to search
-- keymap("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", opts)

-- Auto format
--keymap("n", "<Esc><Esc>", "gg=G<C-o>", opts)
-- keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)

--keymap("n", "<Esc><Esc>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)

-- Fast close
-- keymap("n", "<leader>q", ":bd<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":q!<CR>", opts)
keymap("n", "<leader>r", ":w<CR>", opts)

-- Faster visual block mode
keymap("n", "vv", "V", opts)

-- Shortcut to find and replace
keymap("n", "<leader>f", "/", opts)
keymap("n", "<leader>s", ":%s/", opts)
keymap({ "x", "v" }, "<leader>s", ":s/", opts)

-- Shortcut to find
keymap("n", "ff", "/", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Remap Esc to also exit from terminal mode
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- Jump around more easily
keymap({ "n", "x", "v" }, "<S-j>", "9j", opts)
-- keymap({ "n", "x", "v" }, "<S-j>", "<C-d>zz", opts)
keymap({ "n", "x", "v" }, "<S-k>", "9k", opts)
-- keymap({ "n", "x", "v" }, "<S-k>", "<C-u>zz", opts)

-- Go to definition
-- keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- Lsp keymaps
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "M", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)




-- Move line after the current one up
-- keymap("n", "<C-j>", "gJdw", opts)
keymap("n", "<C-j>", "J", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<leader>k", ":BufferNext<CR>", opts)
-- keymap("n", "<leader>j", ":BufferPrevious<CR>", opts)
-- keymap("n", "<leader>h", ":BufferMovePrevious<CR>", opts)
-- keymap("n", "<leader>l", ":BufferMoveNext<CR>", opts)

keymap("n", "<leader>k", ":bnext<CR>", opts)
keymap("n", "<leader>j", "<c-6>", opts)
keymap("n", "<leader>l", "<C-i>", opts)
keymap("n", "<leader>h", "<C-o>", opts)

-- Remove the search when pressing Escape
-- vim.api.nvim_set_keymap('n', '<esc>', ':noh<CR>', { noremap = true, silent = true })
keymap("n", "<esc>", ":noh<CR>", opts)

-- Save with Control+S
keymap({ "n", "i", "v", "c" }, "<C-s>", "<Esc>:w<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "p", '"_dP', opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Make so that when pasting over something it doesnt fuck up the buffer
keymap("x", "p", [["_dP]])

vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]])
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

-- Makes so that you can go to the start or end of line (like _ and $) with shift+h and shift+l (good shit)
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)

keymap("n", "<leader>ww", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

