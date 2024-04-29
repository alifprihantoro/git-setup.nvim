local isWk, wk = pcall(require, 'which-key')
local isGh, MAPS_GH = pcall(require, 'muryp-gh.maps')
local M = require 'muryp-git-setup'

if M.useMaps and isWk then
  wk.register({ g = { name = '+GIT' } }, M.MAPS[2])
  wk.register({ gg = M.MAPS[1] }, M.MAPS[2])
  if isGh then
    require 'muryp-gh'
    wk.register({ gh = MAPS_GH }, M.MAPS[2])
  end
end