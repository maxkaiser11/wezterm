local platform = require('utils.platform')

---@type Config
local options = {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   ssh_domains = {},

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {},
}

if platform.is_win then
   options.ssh_domains = {
      {
         name = 'ssh:wsl',
         username = 'maxkaiser',
         remote_address = 'localhost',
         multiplexing = 'None',
         default_prog = { 'bash', '-l' },
         assume_shell = 'Posix',
      },
   }

   options.wsl_domains = {
      {
         name = 'wsl:ubuntu',
         distribution = 'Ubuntu',
         username = 'maxkaiser',
         default_cwd = '/home/maxkaiser',
         default_prog = { 'bash', '-l' },
      },
      {
         name = 'wsl:ubuntu-22.04',
         distribution = 'Ubuntu-22.04',
         default_prog = { 'bash', '-l' },
      },
   }

   -- WSL is the primary environment: new windows/tabs open in Ubuntu
   options.default_domain = 'wsl:ubuntu'
end

return options
