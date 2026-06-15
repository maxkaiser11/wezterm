local platform = require('utils.platform')

---@type Config
local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   -- Full path to the PowerShell 7 app-execution alias. Using the alias path
   -- (rather than bare 'pwsh') is stable across pwsh updates and doesn't depend
   -- on PATH, which on this machine pointed at a removed versioned folder.
   local pwsh = os.getenv('LOCALAPPDATA') .. '\\Microsoft\\WindowsApps\\pwsh.exe'

   options.default_prog = { pwsh, '-NoLogo' }
   options.launch_menu = {
      { label = 'PowerShell Core',    args = { pwsh, '-NoLogo' } },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt',     args = { 'cmd' } },
      { label = 'Nushell',            args = { 'nu' } },
      { label = 'Msys2',              args = { 'ucrt64.cmd' } },
      {
         label = 'Git Bash',
         args = { 'C:\\Users\\User\\scoop\\apps\\git\\current\\bin\\bash.exe' },
      },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash',    args = { 'bash', '-l' } },
      { label = 'Fish',    args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh',     args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh',  args = { 'zsh', '-l' } },
   }
end

return options
