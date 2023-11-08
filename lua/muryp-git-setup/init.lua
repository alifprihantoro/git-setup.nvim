local mapping = require('muryp-git-setup.utils.mapping')
local MAPS = require('muryp-git-setup.maps')

local M = {}

_G.MURYP_SSH_PATH = { '$HOME/.ssh/github' }
M.maps = function()
  mapping({ g = MAPS }, { prefix = "<leader>", noremap = true })
end

M.MAPS = MAPS

M.resgisterTelescope = function()
  local plug               = require('telescope.builtin')
  local git                = require('muryp-git-setup.api')

  plug.git_flow            = git.gitFlow
  plug.git_commit_ssh_push = git.push
  plug.git_pull            = git.pull
end

return M