[![License: Apache](https://img.shields.io/badge/License-Apache-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Neovim version](https://img.shields.io/badge/Neovim-0.8.x-green.svg)
![Lua version](https://img.shields.io/badge/Lua-5.4-yellow.svg)
[![Repo Size](https://img.shields.io/github/repo-size/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim)
[![Latest Release](https://img.shields.io/github/release/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/releases/latest)
[![Last Commit](https://img.shields.io/github/last-commit/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/commits/master)
[![Open Issues](https://img.shields.io/github/issues/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/issues)

# Plugin Nvim MuryP Git
easy use git, with telescope and wichkey.
## requirement
- nvim 0.8+ (recommendation)
## install
- lazy.nvim
```lua
{
  'muryp/muryp-git-setup.nvim',
  config = function()
    require('muryp-git-setup').setup({})
  end
}
```