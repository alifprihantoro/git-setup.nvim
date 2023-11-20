local isWk, wk = pcall(require, 'which-key')
local M = require('muryp-git-setup')

if M.useMaps and isWk then
  wk.register({ gg = M.MAPS[1] },M.MAPS[2] )
end