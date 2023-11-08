local picker = require "muryp-git-setup.utils.picker"

local M = {}
---@return string : check is commit or conflict
local function checkCommitConflict()
  local isTroble = vim.fn.system(
  "[[ $(git diff --check) == '' ]] && echo $([[ $(git status --porcelain) ]] && echo 'true' || echo 'no_commit...') || echo 'conflict...'")
  if isTroble == 'true\n' then
    return 'git add . && git commit'
  else
    return 'echo ' .. string.gsub(isTroble, '\n', '')
  end
end
---@return string : commit cmd
M.gitCommitCmd = function()
  return "cd %:p:h && cd $(git rev-parse --show-toplevel) && " .. checkCommitConflict()
end

M.gitCommit = function()
  vim.cmd('term ' .. M.gitCommitCmd())
end
---@param FIRST_LETTER string FIRST_LETTER cmd
---@return string
M.addSsh = function(FIRST_LETTER)
  local SshPath = _G.MURYP_SSH_PATH
  local SSH_PATH = ''
  for _, PATH in pairs(SshPath) do
    SSH_PATH = SSH_PATH .. PATH .. ' '
  end
  return FIRST_LETTER .. [[eval "$(ssh-agent -s)" && ssh-add ]] .. SSH_PATH
end
---@param DEFAULT_REMOTE string
---@return string
M.gitPush = function(DEFAULT_REMOTE)
  local REMOTE = vim.fn.input('what repo ? ', DEFAULT_REMOTE)
  local PULL = vim.fn.input('Use PUll (y/n) ? ')
  local BRANCH = vim.fn.system('git symbolic-ref --short HEAD'):gsub('\n', ''):gsub('\r', '')
  local TARGET_HOST = REMOTE .. ' ' .. BRANCH
  local PUSH =
      ' [[ $(git diff --check) == "" ]] && git push ' ..
      TARGET_HOST .. ' || echo "\\033[31merror: you have conflict:\\n$(git diff --check)"'
  if PULL == 'y' or PULL == 'Y' then
    PULL = " && git pull " .. TARGET_HOST .. ' &&'
  else
    PULL = ' &&'
  end
  return PULL .. PUSH
end
---@param opts string | nil remote
---@return nil vim.cmd commit, pull, push with ssh,
M.gitSshPush = function(opts)
  local DEFAULT_REMOTE
  if opts == nil then
    DEFAULT_REMOTE = 'origin'
  else
    DEFAULT_REMOTE = opts
  end
  return vim.cmd('term ' .. M.gitCommitCmd() .. M.addSsh(' && ') .. M.gitPush(DEFAULT_REMOTE))
end
---@param opts string | nil remote name
---@return nil vim.cmd pull with ssh,
M.pull = function(opts)
  local DEFAULT_REMOTE
  if opts == nil then
    DEFAULT_REMOTE = 'origin'
  else
    DEFAULT_REMOTE = opts
  end
  local BRANCH = vim.fn.system('git symbolic-ref --short HEAD') ---@type string
  vim.cmd('term ' .. M.addSsh('') .. '&& git pull ' .. DEFAULT_REMOTE .. ' ' .. BRANCH)
end
---@return nil vim.cmd push single with ssh
M.singlePush = function()
  return vim.cmd(M.addSsh('term ') .. M.gitPush('origin'))
end

-- with telescope

M.gitFlow = function()
  local ListBranch = {} ---@type string[]
  local LIST_BRANCH = vim.api.nvim_command_output('echo system("git branch")') ---@type string
  local NAME_CURRENT_BRANCH = vim.api.nvim_command_output('echo system("echo $(git symbolic-ref --short HEAD)")') ---@type string
  local BRANCH_DEL_ENTER = string.gsub(NAME_CURRENT_BRANCH, "\n", "")
  ---check is not current branch and *
  for BRANCH in string.gmatch(LIST_BRANCH, "%S+") do
    if BRANCH ~= "*" and BRANCH ~= BRANCH_DEL_ENTER then
      table.insert(ListBranch, BRANCH)
    end
  end
  local function callback(selection)
    print(vim.inspect(vim.cmd('!git checkout ' .. selection)))
  end
  picker({
    opts = ListBranch,
    callBack = callback,
    title = "choose branch want to merge"
  })
end


---@return nil gitSshPush git commit, pull, push with opts remote
M.push = function()
  local LIST_REMOTE = vim.fn.systemlist("git remote") --- @type string[]
  local function callback(selection)
    M.gitSshPush(selection)
  end
  picker({
    opts = LIST_REMOTE,
    callBack = callback,
    title = "choose remote want to push"
  })
end

---@return nil gitPull git pull with opts remote
M.pullList = function()
  local LIST_REMOTE = vim.fn.systemlist("git remote") --- @type string[]
  local function callback(selection)
    M.pull(selection)
  end
  picker({
    opts = LIST_REMOTE,
    callBack = callback,
    title = "choose remote want to pull"
  })
end

return M