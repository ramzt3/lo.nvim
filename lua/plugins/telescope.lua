return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,                       -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,                           -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                    }
                }
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>so', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>sq', builtin.quickfix, {})
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Telescope buffers' })

        -- Rip grep + Fzf
        vim.keymap.set('n', '<leader>sg', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)

        -- Find instance instance of current view being included
        vim.keymap.set('n', '<leader>sc', function()
            local filename_without_extension = vim.fn.expand('%:t:r')
            builtin.grep_string({ search = filename_without_extension })
        end, { desc = "Find current file: " })

        -- Grep current string (for when gd doesn't work)
        vim.keymap.set('n', '<leader>ss', function()
            builtin.grep_string({})
        end, { desc = "Find current string: " })

        -- find files in vim config
        vim.keymap.set('n', '<leader>si', function()
            builtin.find_files({ cwd = "~/.config/nvim/" });
        end)
    end
}
