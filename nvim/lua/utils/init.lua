_G.dump = function(...)
  print(vim.inspect(...))
end

_G.prequire = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local M = {}

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

-- taken from https://github.com/voyeg3r/nvim/blob/master/lua/utils.lua
-- used to trim trailing whitespace
function M.preserve(arguments)
  local arguments = string.format('keepjumps keeppatterns execute %q', arguments)
  -- local original_cursor = vim.fn.winsaveview()
  local unpack = table.unpack or unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_command(arguments)
  local lastline = vim.fn.line('$')
  -- vim.fn.winrestview(original_cursor)
  if line > lastline then
          line = lastline
  end
  --api.nvim_win_set_cursor({0}, {line , col})
end

return M

