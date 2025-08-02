local function get_default_branch_name()
  local res = vim.system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true }):wait()

  return res.code == 0 and 'main' or 'master'
end

return {
  {
    -- diff open vim
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set('n', '<leader>grh', '<CMD>DiffviewFileHistory<cr>', { desc = 'Repo history' })
      vim.keymap.set('n', '<leader>gfh', '<CMD>DiffviewFileHistory --follow %<cr>', { desc = 'File history' })
      vim.keymap.set('v', '<leader>gvh', "<Esc><CMD>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Range history' })
      vim.keymap.set('n', '<leader>glh', '<CMD>.DiffviewFileHistory --follow<CR>', { desc = 'Line history' })
      vim.keymap.set('n', '<leader>grd', '<CMD>DiffviewOpen<CR>', { desc = 'Repo diff' })
      vim.keymap.set('n', '<leader>grdm', function()
        vim.cmd('DiffviewOpen ' .. get_default_branch_name())
      end, { desc = 'Diff against master' })
      vim.keymap.set('n', '<leader>grdM', function()
        vim.cmd('DiffviewOpen HEAD..origin/' .. get_default_branch_name())
      end, { desc = 'Diff against origin/master' })
    end,
  },
}
