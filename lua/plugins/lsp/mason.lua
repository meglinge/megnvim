return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        -- ensure_installed = { "lua_ls", "rust_analyzer" },
        config = function(_, ensure_installed)
            require("mason").setup {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                },
            }
            -- -- 自定义 cmd 来安装列出的所有 mason 二进制文件
            -- vim.api.nvim_create_user_command("MasonInstallAll", function()
            --     vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
            -- end, {})
            -- print("MasonInstallAll")
            -- print(ensure_installed)
            -- vim.g.mason_binaries_list = ensure_installed
        end
    }
}
