return {
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require "octo".setup({
        suppress_missing_scope = {
          projects_v2 = true, -- WARNING: don't remove, this for fix bug
        }
      })
    end
  },
  'nvim-telescope/telescope.nvim',
  'folke/which-key.nvim',
  'muryp/muryp-gh.nvim',
  'lewis6991/gitsigns.nvim',
  'nvim-lua/plenary.nvim',
  'sindrets/diffview.nvim',
  'akinsho/git-conflict.nvim',
}