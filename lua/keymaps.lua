local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
vim.g.mapleader = ' '
local nmappings = {
    { from = 'vv',        to = '<esc>',                                   mode = "vnitx" },
    { from = '<C-s>',     to = ':w<CR>' },
    { from = 'Q',         to = ':q<CR>' },
    { from = '<leader>Q', to = ':q!<CR>' },
    { from = 'Y',         to = '"+y',                                     mode = "v" },
    { from = '<leader>e', to = ':Neotree toggle position=left<CR>' },
    { from = '<leader>f', to = ':Neotree toggle position=float<CR>' },
    { from = '<leader>f', to = '<esc>:Neotree toggle position=float<CR>', mode = "i" },
    { from = '<leader>j', to = ':ClangdSwitchSourceHeader<CR>',           mode = "ivn" },

}
for _, mapping in ipairs(nmappings) do
    local modestr = mapping.mode or "n"
    for i = 1, #modestr do
        map(modestr:sub(i, i), mapping.from, mapping.to, opt)
    end
end
