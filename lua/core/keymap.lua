local keymap = vim.keymap.set
local opt = { noremap = true, silent = true }

-- Drag line in the visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Press J and won't change your cursor location
keymap("n", "J", "mzJ`z")

-- move and make your cursor still in the middle screen
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- make your cursor in the middle screen when search
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Yank into system clipboard
keymap({"n", "v"}, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])

-- Substitute the word your cursor in
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- auto chmod +x
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opt)

-- The black hole register
keymap({"n", "v"}, "<leader>d", [["_d]])

keymap("n", "<leader><leader>", function()
    vim.cmd("so")
end)
keymap("n", "<leader>w", function()
    vim.cmd("w")
end)
keymap("n", "<leader>q", function()
    vim.cmd("wq")
end)
