return function()
  local M = require('muryp-git-setup.api')
  return {
    name = "GIT",
    b = { ':Telescope git_branches<CR>', "BRANCH" },
    f = { ':Telescope git_flow<CR>', "FLOW" },
    S = { ':Telescope git_status<CR>', "GIT_STATUS" },
    c = { ':term git commit<CR>', "COMMIT" },
    v = { function()
      M.gitMainCmd({
        add = true,
        commit = true,
      })
    end, "ADD_ALL+COMMIT" },
    p = {
      name = "PUSH",
      p = { function()
        M.gitMainCmd({
          add = true,
          commit = true,
          ssh = true,
          remote_quest = true,
          pull_quest = true,
          push = true,
        })
      end, "ADD+COMMIT+SSH+PULL+PUSH" },
      P = { function()
        M.gitMainCmd({
          remote_quest = true,
          push = true,
        })
      end, "PUSH" },
      a = { function()
        vim.cmd(':term ' .. M.SSH_CMD() .. ' && git push --all<CR>')
      end, "PUSH ALL WITH SSH" },
      A = { ':term git push --all<CR>', "PUSH ALL" },
      s = { function()
        M.gitMainCmd({
          push = true,
          remote_quest = true,
          pull_quest = true,
          ssh = true,
        })
      end, "SSH+PULL+PUSH" },
      S = { function()
        M.gitMainCmd({
          push = true,
          remote_quest = true,
          ssh = true,
        })
      end, "SSH+PUSH" },
    },
    P = {
      name = "PULL",
      A = { ':term git pull --all<CR>', "PULL ALL" },
      a = { function()
        vim.cmd(':term ' .. M.SSH_CMD() .. ' && git pull --all<CR>')
      end, "PULL ALL WITH SSH" },
      p = { function()
        M.gitMainCmd({
          remote_quest = true,
          pull = true,
        })
      end, "PULL THIS BRANCH" },
      P = { function()
        M.gitMainCmd({
          remote_quest = true,
          pull = true,
          ssh = true,
        })
      end, "PULL THIS BRANCH WITH SSH" },
    },
    o = {
      name = "WITH TELESCOPE OPTS",
      p = { ':Telescope git_commit_ssh_push<CR>', "COMMIT+SSH+PULL+PUSH" },
      P = { ':Telescope git_pull<CR>', "PULL" },
    },
    d = {
      name = "DIFF_VIEW",
      o = { ':DiffviewOpen<CR>', 'DIFF_OPEN' },
      c = { ':DiffviewClose<CR>', 'DIFF_CLOSE' },
      t = { ':DiffviewFileHistory<CR>', 'FILE_HISTORY' },
    },
    B = { ':Gitsigns blame_line<CR>', 'BLAME_LINE' },
    C = {
      name = "CONFLICT",
      l = { ':GitConflictListQf<CR>', 'LIST' },
      r = { ':GitConflictRefresh<CR>', 'REFRES' },
      n = { ':GitConflictNextConflict<CR>', 'NEXT' },
      p = { ':GitConflictPrevConflict<CR>', 'PREV' },
      t = { ':GitConflictChooseTheirs<CR>', 'CHOOSE_THEIR' },
      b = { ':GitConflictChooseBoth<CR>', 'CHOOSE_BOTH' },
      o = { ':GitConflictChooseOur<CR>', 'CHOOSE_OUR' },
      N = { ':GitConflictChooseNone<CR>', 'CHOOSE_NONE' },
    },
  }
end