local vim = vim
local api = vim.api

local M = {}

-- autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

local autoCommands = {
    mkdown_file_width = {
        {"BufRead,BufNewFile", "*.md", "setlocal textwidth=120"}
    },
    clean_trailing_spaces = {
        {"BufWritePre", "*", [[lua require("utils").preserve('%s/\\s\\+$//ge')]]}
    },
    -- format = {
    --     {"BufWritePre", "*", "Neoformat"}
    -- };
    -- open_folds = {
    --     {"BufReadPost,FileReadPost", "*", "normal zR"}
    -- }
}

function M.setup()
    M.nvim_create_augroups(autoCommands)
end

return M

