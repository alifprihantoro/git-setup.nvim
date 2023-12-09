local status, gitconflict = pcall(require, 'git-conflict')
if not status then
  return
end
gitconflict.setup {
  default_mappings = {
    ours = 'o',
    theirs = 't',
    none = '0',
    both = 'b',
    next = 'n',
    prev = 'p',
  },
  default_commands = true, -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  highlights = {
    incoming = 'DiffText',
    current = 'DiffAdd',
  },
}
