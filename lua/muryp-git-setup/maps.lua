local M = require('lua.muryp-git-setup.api')
return {
  name = "GIT",
  b = { ':Telescope git_branches<CR>', "BRANCH" },
  f = { ':Telescope git_flow<CR>', "FLOW" },
  s = { ':Telescope git_status<CR>', "STATUS" },
  c = { ':term git commit<CR>', "COMMIT" },
  v = { M.gitCommit, "ADD_ALL+COMMIT" },
  p = {
    name = "PUSH",
    p = { M.gitSshPush, "COMMIT+SSH+PULL+PUSH" },
    a = { ':term git push --all<CR>', "PUSH ALL" },
    s = { M.singlePush, "SSH+PULL+PUSH" },
  },
  P = {
    name = "PULL",
    A = { ':term git pull --all<CR>', "PULL ALL" },
    P = { M.pull, "pull" },
  },
  o = {
    name = "WITH TELESCOPE OPTS",
    p = { ':Telescope git_commit_ssh_push<CR>', "COMMIT+SSH+PULL+PUSH" },
    P = { ':Telescope git_pull<CR>', "PULL" },
  },
}