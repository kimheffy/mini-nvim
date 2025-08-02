local set = vim.opt_local

local state = {
  term = {
    buf = -1,
    win = -1,
  },
}

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', {}),
  callback = function()
    set.number = false
    set.relativenumber = false
    set.scrolloff = 0
  end,
})

local function create_term(opts)
  opts = opts or {}

  local win_config = {
    split = 'below',
  }

  local buf = nil

  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return {
    buf = buf,
    win = win,
  }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.term.win) then
    state.term = create_term { buf = state.term.buf }

    if vim.bo[state.term.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.term.win)
  end
end

-- Easily hit escape in terminal mode.
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

vim.keymap.set({ 'n', 't' }, ',st', toggle_terminal)

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set('n', ',St', function()
  vim.cmd.new()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

-- Open a terminal on a new tab
vim.keymap.set('n', ',ft', function()
  vim.cmd.new()
  vim.cmd.wincmd 'T'
  vim.wo.winfixheight = true
  vim.cmd.term()
end)
