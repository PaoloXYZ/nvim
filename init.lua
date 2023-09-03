-- colemak translation layer
vim.cmd(
	[[set langmap=fe,pr,gt,jy,lu,ui,yo,\\;p,rs,sd,tf,dg,nj,ek,il,o\\;,kn,FE,PR,GT,JY,LU,UI,YO,:P,RS,SD,TF,DG,NJ,EK,IL,O:,KN]]
)

vim.g.mapleader = " "

-- ";" and ":" both open command mode
vim.keymap.set({"v", "n"}, ";", ":")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- replace currently selected text with default register without yanking it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank into clipboard
vim.keymap.set({"n", "v"}, "<leader>Y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- deletes without overrding clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
-- this thing is weird keep it in mind but shift j in normal mode has to be assigned to smth better no?
-- vim.keymap.set("n", "J", "mzJ`z")

-- replace all instances of currently hovered word line below for vim
-- change current file permission to readonly to read/write permissions (windows does not recognize chmod kekl)
if vim.g.vscode then
    print("VSඞ")
else
    print("native")
    vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
	vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
	vim.keymap.set("n", "<C-y>", ":bnext<CR>")
	vim.keymap.set("n", "<C-u>", ":bprevious<CR>")
--  Ctrl + / to comment out current line in normal mode or selection in visual
    vim.keymap.set({"n", "v"}, "<C-_>", ":Commentary<CR>")
    -- OPTIONS
	vim.opt.scrolloff = 8
	vim.opt.signcolumn = "yes"
	vim.opt.colorcolumn = "80"
	vim.opt.number = true
	vim.opt.relativenumber = true
end

-- OPTIONS
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.incsearch = true
-- nvim tree reccomends adding these options 
-- https://github.com/nvim-tree/nvim-tree.lua#quick-start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)    

require("lazy").setup({
    {
        "williamboman/mason.nvim",
        opts = {} -- avoids having to specify: "require("mason").setup()"
    },
    {
        "folke/tokyonight.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
    },
    {
        'tpope/vim-commentary'
    },
    {
        'max397574/better-escape.nvim',
        opts = {
            mapping = {'uy'},
            clear_empty_lines = false,
            keys = '<Esc>'
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            view = {
                width = 30,
            },
            filters = {
                dotfiles = true,
            }
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {}
    }
}
)

--set colorscheme (theme
vim.cmd[[colorscheme tokyonight]]

-- telescope keybinds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- nvim-tree keybinds
vim.keymap.set({'n', 'v'}, '<leader>e', ':NvimTreeToggle<CR>')
-- automatically close nvim-tree if its the last buffer left open
vim.o.confirm = true
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
    callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("quit") end 
    end
})
