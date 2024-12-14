-- Git integration
return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  keys = {
    { ']h', ':silent Gitsigns next_hunk<CR>'},
    { '[h', ':silent Gitsigns prev_hunk<CR>'},
    { '<leader>gs', ':Gitsigns stage_hunk<CR>', desc = 'Stage Hunk (Gitsigns)'},
    { '<leader>gS', ':Gitsigns undo_stage_hunk<CR>', desc = 'Undo Stage Hunk (Gitsigns)'},
    { '<leader>gp', ':Gitsigns preview_hunk<CR>', desc = 'Preview Hunk (Gitsigns)'},
    { '<leader>gb', ':Gitsigns blame_line<CR>', desc = 'Blame Line (Gitsigns)'},
  },
  opts = {
    preview_config = {
      border = { '', '', '', ' ' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '┄' },
      untracked    = { text = '┊' },
    },
  },
}
