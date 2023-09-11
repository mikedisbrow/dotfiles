-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--[[ options.lua ]]
-- https://neovim.io/doc/user/setions.html
-- https://neovim.io/doc/user/vim.oions.html
-- vim.o    set vim.oion
-- vim.bo   set buffer-scoped vim.oion
-- vim.wo   set window-scoped vim.oion
-- vim.go   set global vim.oion
-- vim.opt  list and map-style vim.oions.
--      use tables for list or objects to add / remove

-- [[ appearance / ui ]]
--
-- (bool: default off) Show the line number relative to the line with the cursor in front of each line
vim.o.relativenumber = false
-- (bool: defaault off) Highlight the screen column of the cursor with CursorColumn
vim.o.cursorcolumn = false
-- (bool: default off) highlight line
vim.o.cursorline = true
-- (str: default "both") Comma-separated list of settings for how 'cursorline' is displayed
vim.opt.cursorlineopt = { "number" }
-- (str: default "0") when and how to draw the foldcolumn (auto, auto:[1-9], 0, [1-9])
vim.opt.foldcolumn = "auto"
-- (str: default "manual") kind of folding used for the current window
-- https://neovim.io/doc/user/options.html#'foldmethod'
vim.opt.foldmethod = "syntax"
-- (str: default "") Characters to fill the statuslines, vertical separators and special lines in the window
-- https://neovim.io/doc/user/options.html#'fillchars'
-- vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
-- (default "b,s") which keys make cursor wrap lines
-- https://neovim.io/doc/user/options.html#'whichwrap'
-- vim.opt.whichwrap += "<,>,[,],h,l"
-- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
vim.opt.whichwrap = "h,l,<,>,[,],~"

-- [[ indent / wrap / invisibles ]]

-- (bool: default on) wrap lines
vim.o.wrap = true
-- (bool: default off) wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
vim.o.linebreak = true
-- (str: default "") String to put at the start of lines that have been wrapped, Useful values are "> " or "+++ ":
-- vim.opt.showbreak = "> "
-- (bool: default off) Every wrapped line will continue visually indented preserving horizontal blocks of text
vim.o.breakindent = true
-- (bool: default off) Copy structure of existing lines when autoindenting
vim.o.copyindent = true
-- (bool: default off) ound indent to multiple of 'shiftwidth'
vim.o.shiftround = true
-- (num: default 8) Number of spaces to use for each step of (auto)indent
vim.o.shiftwidth = 4
-- (bool: default on) copy indent from current line when starting a new line
vim.o.autoindent = true
-- (bool: default off) smart autoindenting when starting a new line
vim.o.smartindent = true
-- (bool: default off) use spaces to insert a <Tab>
vim.o.expandtab = true
-- (bool: default on) <Tab> in front of a line inserts blanks according to 'shiftwidth'.
vim.o.smarttab = true
-- (num: default 8) Number of spaces that a <Tab> in the file counts for
vim.o.tabstop = 4
-- (num: default 0) Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
vim.o.softtabstop = 4
-- (bool: default off) show tabs as ">", trailing spaces as "-", and non-breakable space characters as "+"
-- vim.opt.list = true
-- (str: default "tab:> ,trail:-,nbsp:+")
-- https://neovim.io/doc/user/options.html#'listchars'
-- vim.opt.listchars = { tab = ">-", trail = "-", extends = ">", precedes = "<", space = "∙", nbsp = "+", eol = "¬" }

-- [[ search / complete ]]

-- (bool: default on) While typing a search command, show where the pattern, as it was typed so far, matches
vim.o.incsearch = true
