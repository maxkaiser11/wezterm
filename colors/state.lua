-- Persists the color scheme selected at runtime (Super+C to cycle,
-- Super+Ctrl+C to fuzzy-pick; see `config/bindings.lua`) so the choice is
-- restored on the next launch. The scheme *name* is stored rather than its
-- index so the saved choice survives reordering of `colors/schemes.lua`.

local wezterm = require('wezterm')
local schemes = require('colors.schemes')

local M = {}

-- Kept out of the repo via `.gitignore`.
local STATE_FILE = wezterm.config_dir .. '/.color-scheme'

---Read the saved scheme name, or `nil` if nothing has been saved yet.
---@return string?
function M.load_name()
   local file = io.open(STATE_FILE, 'r')
   if not file then
      return nil
   end
   local name = file:read('*l')
   file:close()
   if name == nil or name == '' then
      return nil
   end
   return name
end

---Persist the given scheme name.
---@param name string
function M.save_name(name)
   local file = io.open(STATE_FILE, 'w')
   if not file then
      wezterm.log_error('colors.state: could not write ' .. STATE_FILE)
      return
   end
   file:write(name)
   file:close()
end

---Resolve the persisted scheme to an index into `colors/schemes.lua`.
---Falls back to the first scheme when nothing is saved or the saved name is
---no longer present.
---@return integer
function M.initial_index()
   local name = M.load_name()
   if name then
      for i, entry in ipairs(schemes) do
         if entry.name == name then
            return i
         end
      end
   end
   return 1
end

return M
