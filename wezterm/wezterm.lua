-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- local mydomains = require 'mydomains'
-- This will hold the configuration.
local config = wezterm.config_builder()
-- mydomains.apply_to_config(config)
-- config.color_scheme = "dank-theme"
----------------------------------------------------------------------------------------------------
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    icons_enabled = true,
    -- theme = 'Catppuccin Mocha',
    theme = 'GruvboxDark',
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { 'u' },
    tab_active = {{ Background = { Color = 'brown' } },
      'index',
      { 'process', padding = 1},
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'process', padding = { left = 1, right = 1 } } },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime', 'battery' },
    tabline_z = { 'domain' },
  },
  extensions = {},
})
tabline.apply_to_config(config)
----------------------------------------------------------------------------------------------------
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Batman'
-- config.color_scheme = 'Later This Evening (Gogh)'
config.color_scheme = 'dank-theme'

-- DIsable all bindings for debugging
config.disable_default_key_bindings = false


-- config.font = wezterm.font 'AdwaitaMono'
config.font = wezterm.font 'JetBrains Mono NF'
-- config.font = wezterm.font 'Fira Code'
-- config.font = wezterm.font 'monospace'
-- config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 13
-- config.font = wezterm.font("MesloLGS NF")
config.window_padding = {
  left=2,
  right= 2,
  top=2,
  bottom=0
}
config.hide_tab_bar_if_only_one_tab = true


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_domain = 'WSL:Ubuntu-24.04'
end



config.command_palette_font_size = 12.0
config.command_palette_bg_color = "#1f1f1f"
config.command_palette_bg_color = white

config.command_palette_rows = 10
config.window_decorations = "RESIZE"


config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'zellij',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}


config.keys = {
  {
    key = '9',
    mods = 'ALT',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS' },
  },
  { key = 'z', mods = 'ALT', action = wezterm.action.ShowLauncher },

}
copy_mode = wezterm.gui.default_key_tables().copy_mode
table.insert(copy_mode, { key = 'm', mods = 'NONE', action = act.CopyMode 'MoveLeft' })

table.insert(copy_mode, { key = 'n', mods = 'NONE', action = act.CopyMode 'MoveDown' })
table.insert(copy_mode, { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveUp' })
table.insert(copy_mode, { key = 'i', mods = 'NONE', action = act.CopyMode 'MoveRight' })
config.key_tables = {
  copy_mode = copy_mode
}
-- print("Hello World!")





-- ==================== Backgroud stuff ==========================
-- local dimmer = { brightness = 0.02, hue = 1.0, saturation = 0.5 }
local dimmer = { brightness = 0.5, hue = 0.7, saturation = 0.7 }
local dimmer2 = { brightness = 0.03, hue = 1.0, saturation = 1.0 }


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  config.background = {
    {

      -- source = { File = 'c:/users/osto/.config/wezterm/bg.jpg'},
      source = { File = 'C:/Users/osto/.config/wezterm/wpl2.jpg'},
      repeat_x = 'Mirror',
      hsb = dimmer,
      -- When the viewport scrolls, move this layer 10% of the number of
      -- pixels moved by the main viewport. This makes it appear to be
      -- further behind the text.
      -- attachment = { Parallax = 0.1 },    
    }
  }
  
else 


  -- config.background = {
  --   {
  --     -- source = { File = '.config/wezterm/bg.jpg'},
  --     source = { File = '.config/wezterm/wpl2.jpg'},

  --     repeat_x = 'Mirror',
  --     hsb = dimmer,
  --     -- When the viewport scrolls, move this layer 10% of the number of
  --     -- pixels moved by the main viewport. This makes it appear to be
  --     -- further behind the text.
  --     -- attachment = { Parallax = 0.1 },    
  --   },
    
  -- }

end




-- and finally, return the configuration to wezterm
return config


