-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remap the key used to leave insert mode
-- map("i", "jk", "", {})
-- Use jj to exit insert mode
vim.keymap.set("i", "jj", "<Esc>", {})

vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q!<CR>", { noremap = true })
vim.keymap.set("n", "<leader>s", ":so %<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC<CR>", { noremap = true })
vim.keymap.set("n", "<leader>sv", ":w<CR>:so %<CR>:q<CR>", { noremap = true })

-- disable arrow keys because habits
vim.keymap.set("", "<up>", "<nop>", { silent = true })
vim.keymap.set("", "<down>", "<nop>", { silent = true })
vim.keymap.set("", "<left>", "<nop>", { silent = true })
vim.keymap.set("", "<right>", "<nop>", { silent = true })

-- buffer navigation
vim.keymap.set("n", "<leader>bp", ":bprev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>", { desc = "Delete buffer" })

-- tab navigation
vim.keymap.set("n", "<leader>tp", ":tabprevious<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "<leader>tn", ":tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>td", ":tabclose<cr>", { desc = "Close tab" })

-- [[ neo-tree ]]
vim.keymap.set("n", "<leader>nt", "[[:Neotree filesystem reveal left]]")

--[[
      easier moving of code blocks
      Try to go into visual mode (v), thenselect several lines of code
      here and then press ``>`` several times.
--]]
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- move selected line(s) up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- scroll window up/down
vim.keymap.set("i", "<C-e>", "<ESC><C-e>", { silent = true })
vim.keymap.set("i", "<C-y>", "<ESC><C-y>", { silent = true })
