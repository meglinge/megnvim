return {
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
            end
            cmp.setup {
                -- 指定 snippet 引擎
                snippet = {
                    expand = function(args)
                        -- For `vsnip` users.
                        vim.fn["vsnip#anonymous"](args.body)

                        -- For `luasnip` users.
                        -- require('luasnip').lsp_expand(args.body)

                        -- For `ultisnips` users.
                        -- vim.fn["UltiSnips#Anon"](args.body)

                        -- For `snippy` users.
                        -- require'snippy'.expand_snippet(args.body)
                    end,
                },
                -- 来源
                sources = require("cmp").config.sources({
                    { name = 'nvim_lsp' },
                    -- For vsnip users.
                    { name = 'vsnip' },
                    { name = "copilot", group_index = 2 },
                    -- For luasnip users.
                    -- { name = 'luasnip' },
                    --For ultisnips users.
                    -- { name = 'ultisnips' },
                    -- -- For snippy users.
                    -- { name = 'snippy' },
                }, { { name = 'buffer' },
                    { name = 'path' }
                }),

                -- 快捷键
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-h>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                -- 使用lspkind-nvim显示类型图标
                formatting = {
                    format = require("lspkind").cmp_format({
                        with_text = true, -- do not show text alongside icons
                        maxwidth = 50,    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        before = function(entry, vim_item)
                            -- Source 显示提示来源
                            vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                            return vim_item
                        end,
                        mode = "symbol",
                        symbolmap = { Copilot = "" }
                    })
                },
            }
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "hrsh7th/cmp-buffer",
    },
    {
        "hrsh7th/cmp-path",
    },
    {
        "hrsh7th/cmp-cmdline",
    },

    {
        "hrsh7th/cmp-vsnip",
    },
    {
        "hrsh7th/vim-vsnip"
    },
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "onsails/lspkind-nvim",
    }
}
