-- C:\Users\%USERNAME%\AppData\Local\nvim\init.lua
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
	vim.keymap.set("i", "uy", "<Esc>")
	vim.keymap.set("i", "yu", "<Esc>")
	vim.keymap.set("n", "<C-y>", ":bnext<CR>")
	vim.keymap.set("n", "<C-u>", ":bprevious<CR>")
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
