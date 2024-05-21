local MAPS = require 'muryp-git-setup.maps'()
local OPTS = { prefix = '<leader>', noremap = true, mode = 'n', silent = true }
local M = {}

_G.MURYP_SSH_PATH = { '$HOME/.ssh/github' }
_G.MURYP_REMOT_DEFAULT = 'origin'
M.MAPS = { MAPS, OPTS }

local isTelescope, plug = pcall(require, 'telescope.builtin')
if isTelescope then
  local git = require 'muryp-git-setup.api'

  plug.git_flow = git.gitFlow
  plug.git_push = git.push
  plug.git_commit_ssh_push = git.gitCommitPush
  plug.git_pull = git.pull
end

M.useMaps = true

return M