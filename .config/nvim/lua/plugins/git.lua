return {
  -- Поддержка git
  { 
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()

      local function map(mode, l, r, opts)
        opts = opts or { noremap = true, silent = true }
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      local gs = package.loaded.gitsigns

      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- map('n', '<leader>gs', gs.stage_hunk)
      -- map('n', '<leader>gr', gs.reset_hunk)
      -- map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      -- map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      -- map('n', '<leader>gS', gs.stage_buffer)
      -- map('n', '<leader>gu', gs.undo_stage_hunk)
      -- map('n', '<leader>hR', gs.reset_buffer)
      -- map('n', '<leader>gp', gs.preview_hunk)
      -- map('n', '<leader>gb', function() gs.blame_line{full=true} end)
      -- map('n', '<leader>tb', gs.toggle_current_line_blame)
      -- map('n', '<leader>gd', gs.diffthis)
      -- map('n', '<leader>gD', function() gs.diffthis('~') end)
      -- map('n', '<leader>gtd', gs.toggle_deleted)
    end
  }
}
