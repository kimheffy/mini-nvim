local set = vim.keymap.set

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- set('n', '<Esc>', '<cmd>nohlsearch<CR>')

set('n', '<CR>', function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ''
  else
    return '<CR>'
  end
end, { expr = true })

-- set('n', '<leader>ex', '<cmd>source %<cr>', { desc = 'Execute the current file' })

-- TODO: See if i want this remapped to something
-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resizing windows using Alt + hjkl keys
set('n', '<M-l>', '<cmd>:vertical res -5<cr>', { desc = 'Resize vertical by -5' })
set('n', '<M-h>', '<cmd>:vertical res +5<cr>', { desc = 'Resize vertical by +5' })
set('n', '<M-j>', '<cmd>:res -5<cr>', { desc = 'Resize horizontal by -5' })
set('n', '<M-k>', '<cmd>:res +5<cr>', { desc = 'Resize horizontal by +5' })

-- Tabs!
set('n', '<Tab>', '<cmd>:tabnext<cr>', {})
set('n', '<S-Tab>', '<cmd>:tabprev<cr>', {})
