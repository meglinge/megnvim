return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig"
        },
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "neocmake" }

            }
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    print("default handler for " .. server_name)
                    require("lspconfig")[server_name].setup {}
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                ["rust_analyzer"] = function()
                    require 'lspconfig'.rust_analyzer.setup {
                        settings = {
                            ['rust-analyzer'] = {
                                diagnostics = {
                                    enable = false,
                                }
                            }
                        }
                    }
                end,
                ["lua_ls"] = function()
                    require 'lspconfig'.lua_ls.setup {
                        on_init = function(client)
                            local path = client.workspace_folders[1].name
                            if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                                    Lua = {
                                        runtime = {
                                            -- Tell the language server which version of Lua you're using
                                            -- (most likely LuaJIT in the case of Neovim)
                                            version = 'LuaJIT'
                                        },
                                        -- Make the server aware of Neovim runtime files
                                        workspace = {
                                            checkThirdParty = false,
                                            library = {
                                                vim.env.VIMRUNTIME
                                                -- "${3rd}/luv/library"
                                                -- "${3rd}/busted/library",
                                            }
                                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                            -- library = vim.api.nvim_get_runtime_file("", true)
                                        }
                                    }
                                })

                                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                            end
                            return true
                        end
                    }
                end,
                ["clangd"] = function()
                    require 'lspconfig'.clangd.setup {
                        default_config = {
                            cmd = { "clangd", "--background-index --std=c++" },
                            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                            root_dir = {
                                '.clangd',
                                '.clang-tidy',
                                '.clang-format',
                                'compile_commands.json',
                                'compile_flags.txt',
                                'configure.ac',
                                '.git'

                            },
                            single_file_support = true,
                        }
                    }
                end,
                ["neocmake"] = function()
                    require 'lspconfig'.neocmake.setup {
                        default_config = {
                            cmd = { "neocmakelsp", "--stdio" },
                            filetypes = { "cmake" },
                            root_dir = function(fname)
                                return nvim_lsp.util.find_git_ancestor(fname)
                            end,
                            single_file_support = true, -- suggested
                            -- on_attach = on_attach,      -- on_attach is the on_attach function you defined
                            init_options = {
                                format = {
                                    enable = true
                                }
                            }
                        }
                    }
                end

            }
        end
    }
}
