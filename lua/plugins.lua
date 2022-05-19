local execute = vim.api.nvim_command
local fn = vim.fn

-- 实现Packer的自举
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    execute 'packadd packer.nvim'
end

return require('packer').startup(function()
    -- Packer can manage itself
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }

    -- nvim-cmp
    use {
        "hrsh7th/nvim-cmp",
        -- commit = "4f1358e659d51c69055ac935e618b684cf4f1429",
      } -- The completion plugin
      use "hrsh7th/cmp-buffer" -- buffer completions
      use "hrsh7th/cmp-path" -- path completions
      use "hrsh7th/cmp-cmdline" -- cmdline completions
      use "saadparwaiz1/cmp_luasnip" -- snippet completions
      use "hrsh7th/cmp-nvim-lsp"
      use "hrsh7th/cmp-nvim-lua"
      -- use "quangnguyen30192/cmp-nvim-tags"
      use "jsfaint/gen_tags.vim"
      use "ray-x/cmp-treesitter"
      use "f3fora/cmp-spell" -- spell check
    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use "stevearc/aerial.nvim"
    use "ray-x/lsp_signature.nvim" -- show function signature when typing
end)
