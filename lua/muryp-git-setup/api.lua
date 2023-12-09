local picker = require 'muryp-git-setup.picker'
local M = {}
---@class optsGitMainCmd : {ssh?:boolean,add?:boolean,commit?:boolean,pull?:boolean,push?:boolean,pull_quest?:boolean,remote_quest?:boolean,remote?:string} opts what todo

---@return string
M.SSH_CMD = function()
  local SshPath = _G.MURYP_SSH_PATH
  local SSH_PATH = ''
  for _, PATH in pairs(SshPath) do
    SSH_PATH = SSH_PATH .. PATH .. ' '
  end
  return [[eval "$(ssh-agent -s)" && ssh-add ]] .. SSH_PATH
end

---@param callback function callback if success
---@return function exec when not conflict
local cekConflick = function(callback)
  local isConflict = vim.fn.system 'git diff --check'
  if isConflict == '' then
    return callback()
  else
    return vim.api.nvim_err_writeln(isConflict)
  end
end
---@param opts optsGitMainCmd is return string or vim cmd
---@return function : return cmd git ?add, ?commit, ?pull, ?push with ?ssh
M.gitMainCmd = function(opts)
  return cekConflick(function()
    local isCommited = vim.fn.system '[[ $(git status --porcelain) ]] && echo true'
    local CMD = ''
    if isCommited ~= '' and opts.commit == true then
      if opts.add == true then
        CMD = CMD .. 'git add . && '
      end
      CMD = CMD .. 'git commit && '
    end
    local SSH_CMD = ''
    if opts.ssh == true then
      SSH_CMD = M.SSH_CMD() .. ' && '
    end
    local REMOTE = _G.MURYP_REMOT_DEFAULT
    if opts.remote ~= nil then
      REMOTE = opts.remote
    end
    if opts.remote_quest ~= nil then
      REMOTE = vim.fn.input('what remote ? ', REMOTE)
      if REMOTE == '' then
        return vim.api.nvim_err_writeln 'ERR: please input remote name'
      end
    end
    local isPull = ''
    local TARGET_HOST = ''
    if opts.pull == true or opts.push == true then
      local BRANCH = vim.fn.system('git symbolic-ref --short HEAD'):gsub('\n', ''):gsub('\r', '')
      TARGET_HOST = REMOTE .. ' ' .. BRANCH
    end
    if opts.pull_quest == true then
      isPull = vim.fn.input 'Use PUll (y/n) ? '
    end
    if opts.pull == true or isPull == 'y' or isPull == 'Y' then
      vim.cmd('term ' .. SSH_CMD .. 'git pull ' .. TARGET_HOST)
    end
    cekConflick(function()
      if opts.push == true then
        CMD = CMD .. 'git push ' .. TARGET_HOST
      end
      if CMD ~= '' then
        vim.cmd('term ' .. SSH_CMD .. CMD)
      end
    end)
  end)
end

--- TELESCOPE

---@return nil gitPull git pull with opts remote
M.listRemote = function(callback)
  local LIST_REMOTE = vim.fn.systemlist 'git remote' --- @type string[]
  picker {
    opts = LIST_REMOTE,
    callBack = callback,
    title = 'choose remote',
  }
end

---@param selection string|string[] user select
---@param opts optsGitMainCmd
---@return nil callback exec callback with selection in first arg
local cmdGitMain = function(selection, opts)
  ---defind cmd to exec
  ---@param remote string user select
  local cmd = function(remote)
    opts.remote = remote
    M.gitMainCmd(opts)
  end
  if type(selection) == 'table' then
    for _, v in pairs(selection) do
      cmd(v)
    end
  else
    cmd(selection)
  end
end

---@return nil gitSshPush git commit, pull, push with opts remote
M.push = function()
  ---defind callback/after enter
  ---@param selection string|string[] user select
  local callback = function(selection)
    cmdGitMain(selection, {
      add = true,
      commit = true,
      ssh = true,
      pull_quest = true,
      push = true,
    })
  end
  M.listRemote(callback)
end

---@return nil gitPull git pull with opts remote
M.pull = function()
  ---defind callback/after enter
  ---@param selection string|string[] user select
  local callback = function(selection)
    cmdGitMain(selection, {
      ssh = true,
      pull = true,
    })
  end
  M.listRemote(callback)
end

M.gitFlow = function()
  local ListBranch = {} ---@type string[]
  local NAME_CURRENT_BRANCH = vim.fn.system('echo $(git symbolic-ref --short HEAD)'):gsub('\n', ''):gsub('\r', '') ---@type string
  for branch in io.popen('git branch --list | grep -v $(git rev-parse --abbrev-ref HEAD)'):lines() do
    table.insert(ListBranch, branch)
  end
  local function callback(selection)
    vim.cmd('term git checkout ' .. selection .. ' && git merge ' .. NAME_CURRENT_BRANCH)
  end

  picker {
    opts = ListBranch,
    callBack = callback,
    title = 'choose branch want to merge',
  }
end
return M
