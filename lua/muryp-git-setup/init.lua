local MAPS        = require('muryp-git-setup.maps')

local M           = {}

_G.MURYP_SSH_PATH = { '$HOME/.ssh/github' }
M.MAPS            = MAPS
-- M.maps            = function()
-- require('muryp-git-setup.utils.mapping')({ g = MAPS }, { prefix = "<leader>", noremap = true, mode = 'n', silent = true })
-- end

local isWk, plug = pcall(require, 'telescope.builtin')
if isWk then
  local git                = require('muryp-git-setup.api')

  plug.git_flow            = git.gitFlow
  plug.git_commit_ssh_push = git.push
  plug.git_pull            = git.pull
end

return M