-- Selectable color schemes.
-- Each entry is `{ name, scheme, tab }` where:
--   * `scheme` is a full wezterm colors table (applied via `window:set_config_overrides`).
--   * `tab`    is the palette consumed by the custom tab-bar renderer in
--              `events/tab-title.lua` (the built-in `scheme.tab_bar` block is NOT
--              used by that renderer, so the tab colors must be provided here too).
-- Switch between them at runtime with the keybinds in `config/bindings.lua`
-- (ALT+c to cycle, ALT+CTRL+c to fuzzy-pick).

local BAR_BG = 'rgba(0, 0, 0, 0.4)'

-- Build a scheme entry from a small palette spec, keeping the wezterm colors
-- table and the custom tab-bar palette consistent across every scheme.
---@param name string
---@param p table
local function entry(name, p)
   local scheme = {
      foreground = p.fg,
      background = p.bg,
      cursor_bg = p.cursor_bg or p.fg,
      cursor_border = p.cursor_bg or p.fg,
      cursor_fg = p.cursor_fg or p.bg,
      selection_bg = p.selection_bg,
      selection_fg = p.selection_fg or p.fg,
      ansi = p.ansi,
      brights = p.brights,
      tab_bar = {
         background = BAR_BG,
         active_tab = { bg_color = p.tab_active_bg, fg_color = p.tab_active_fg },
         inactive_tab = { bg_color = p.tab_inactive_bg, fg_color = p.tab_inactive_fg },
         inactive_tab_hover = { bg_color = p.tab_inactive_bg, fg_color = p.tab_active_fg },
         new_tab = { bg_color = p.bg, fg_color = p.fg },
         new_tab_hover = { bg_color = p.tab_inactive_bg, fg_color = p.fg, italic = true },
      },
      visual_bell = p.accent,
      scrollbar_thumb = p.tab_inactive_bg,
      split = p.accent,
      compose_cursor = p.accent,
   }

   local hover_bg = p.tab_hover_bg or p.tab_inactive_bg
   local ok = p.brights[3] -- green
   local err = p.brights[2] -- red
   local tab = {
      text_default = { bg = p.tab_inactive_bg, fg = p.tab_inactive_fg },
      text_hover = { bg = hover_bg, fg = p.tab_active_fg },
      text_active = { bg = p.tab_active_bg, fg = p.tab_active_fg },

      unseen_output_default = { bg = p.tab_inactive_bg, fg = p.accent },
      unseen_output_hover = { bg = hover_bg, fg = p.accent },
      unseen_output_active = { bg = p.tab_active_bg, fg = p.accent },

      scircle_default = { bg = BAR_BG, fg = p.tab_inactive_bg },
      scircle_hover = { bg = BAR_BG, fg = hover_bg },
      scircle_active = { bg = BAR_BG, fg = p.tab_active_bg },

      progress_percentage_default = { bg = p.tab_inactive_bg, fg = ok },
      progress_percentage_hover = { bg = hover_bg, fg = ok },
      progress_percentage_active = { bg = p.tab_active_bg, fg = ok },

      progress_error_default = { bg = p.tab_inactive_bg, fg = err },
      progress_error_hover = { bg = hover_bg, fg = err },
      progress_error_active = { bg = p.tab_active_bg, fg = err },

      progress_indeterminate_default = { bg = p.tab_inactive_bg, fg = p.fg },
      progress_indeterminate_hover = { bg = hover_bg, fg = p.fg },
      progress_indeterminate_active = { bg = p.tab_active_bg, fg = p.fg },
   }

   return { name = name, scheme = scheme, tab = tab }
end

-- The custom (catppuccin mocha) scheme keeps the exact tab-bar palette that the
-- renderer used to hard-code, so switching back to it looks identical to before.
local catppuccin_tab = {
   text_default = { bg = '#45475A', fg = '#1C1B19' },
   text_hover = { bg = '#7188b0', fg = '#1C1B19' },
   text_active = { bg = '#89b4fa', fg = '#11111B' },

   unseen_output_default = { bg = '#45475A', fg = '#FFA066' },
   unseen_output_hover = { bg = '#7188b0', fg = '#FFA066' },
   unseen_output_active = { bg = '#89b4fa', fg = '#FFA066' },

   scircle_default = { bg = BAR_BG, fg = '#45475A' },
   scircle_hover = { bg = BAR_BG, fg = '#7188b0' },
   scircle_active = { bg = BAR_BG, fg = '#89b4fa' },

   progress_percentage_default = { bg = '#45475A', fg = '#9df296' },
   progress_percentage_hover = { bg = '#7188b0', fg = '#9df296' },
   progress_percentage_active = { bg = '#89b4fa', fg = '#9df296' },

   progress_error_default = { bg = '#45475A', fg = '#fa3970' },
   progress_error_hover = { bg = '#7188b0', fg = '#fa3970' },
   progress_error_active = { bg = '#89b4fa', fg = '#fa3970' },

   progress_indeterminate_default = { bg = '#45475A', fg = '#f5e0dc' },
   progress_indeterminate_hover = { bg = '#7188b0', fg = '#f5e0dc' },
   progress_indeterminate_active = { bg = '#89b4fa', fg = '#f5e0dc' },
}

-- stylua: ignore
local schemes = {
   {
      name = 'Catppuccin Mocha',
      scheme = require('colors.custom'),
      tab = catppuccin_tab,
   },
   entry('Gruvbox Dark', {
      fg = '#ebdbb2', bg = '#282828',
      cursor_bg = '#ebdbb2', cursor_fg = '#282828',
      selection_bg = '#504945', selection_fg = '#ebdbb2',
      ansi    = { '#282828', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#a89984' },
      brights = { '#928374', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2' },
      tab_active_bg = '#504945', tab_active_fg = '#ebdbb2',
      tab_inactive_bg = '#3c3836', tab_inactive_fg = '#a89984',
      accent = '#fe8019',
   }),
   entry('Kanagawa', {
      fg = '#dcd7ba', bg = '#1f1f28',
      cursor_bg = '#c8c093', cursor_fg = '#1f1f28',
      selection_bg = '#2d4f67', selection_fg = '#dcd7ba',
      ansi    = { '#16161d', '#c34043', '#76946a', '#c0a36e', '#7e9cd8', '#957fb8', '#6a9589', '#c8c093' },
      brights = { '#727169', '#e82424', '#98bb6c', '#e6c384', '#7fb4ca', '#938aa9', '#7aa89f', '#dcd7ba' },
      tab_active_bg = '#363646', tab_active_fg = '#dcd7ba',
      tab_inactive_bg = '#2a2a37', tab_inactive_fg = '#727169',
      accent = '#ff9e3b',
   }),
   entry('One Dark Pro', {
      fg = '#abb2bf', bg = '#282c34',
      cursor_bg = '#528bff', cursor_fg = '#282c34',
      selection_bg = '#3e4451', selection_fg = '#abb2bf',
      ansi    = { '#282c34', '#e06c75', '#98c379', '#e5c07b', '#61afef', '#c678dd', '#56b6c2', '#abb2bf' },
      brights = { '#5c6370', '#e06c75', '#98c379', '#d19a66', '#61afef', '#c678dd', '#56b6c2', '#ffffff' },
      tab_active_bg = '#3e4451', tab_active_fg = '#abb2bf',
      tab_inactive_bg = '#21252b', tab_inactive_fg = '#5c6370',
      accent = '#61afef',
   }),
}

return schemes
