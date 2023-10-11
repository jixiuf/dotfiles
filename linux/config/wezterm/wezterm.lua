-- Pull in the wezterm API
local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.scrollback_lines = 5000
config.font_size = 15
config.font = wezterm.font('Sarasa Term SC Nerd')
-- This is where you actually apply your config choices
-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Chalk'

config.colors = {
  -- The default text color
  foreground = '#dcdccc',
  -- The default background color
  background = '#111111',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#bbc2cf',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#282c34',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#52ad70',

  -- the foreground color of selected text
  selection_fg = '#000000',
  -- the background color of selected text
  selection_bg = '#fffacd',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#444444',

  ansi = {
    '#222222',
    '#cc9393',
    '#7f9f7f',
    '#d0bf8f',
    '#6ca0a3',
    '#dc8cc3',
    '#93e0e3',
    '#989898',
  },
  brights = {
    '#666666',
    '#dca3a3',
    '#bfebbf',
    '#f0dfaf',
    '#8cd0d3',
    '#fcace3',
    '#b3ffff',
    '#ffffff',
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  indexed = { [136] = '#af8700' },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = 'orange',

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = '#000000' },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

  quick_select_label_bg = { Color = 'peru' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { AnsiColor = 'Navy' },
  quick_select_match_fg = { Color = '#ffffff' },
}

config.hide_tab_bar_if_only_one_tab = true

config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})


local copy_mode = nil
local search_mode = nil
local keys = nil
if wezterm.gui then
   -- https://wezfurlong.org/wezterm/config/lua/wezterm.gui/default_key_tables.html
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  search_mode = wezterm.gui.default_key_tables().search_mode

  table.insert(search_mode, { key = 'g', mods = 'CTRL', action = act.CopyMode 'AcceptPattern' })

  table.insert(copy_mode, { key = 'e', mods = 'ALT', action = act.CopyMode 'EditPattern' })
  table.insert(copy_mode, { key = '/', mods = 'NONE', action = act.Search 'CurrentSelectionOrEmptyString' })


     -- wezterm show-keys --lua --key-table copy_mode
  table.insert(copy_mode, { key = 'a', mods = 'NONE', action = act.CopyMode 'Close' })
  table.insert(copy_mode, { key = 'v', mods = 'ALT', action = act.CopyMode 'PageUp' })
  table.insert(copy_mode, { key = 'v', mods = 'CTRL', action = act.CopyMode 'PageDown' })
  table.insert(copy_mode, { key = 'e', mods = 'CTRL',  action = act.CopyMode 'MoveToEndOfLineContent'})
  table.insert(copy_mode, { key = 'a', mods = 'CTRL',  action = act.CopyMode 'MoveToStartOfLineContent'})
  table.insert(copy_mode,    { key = '2', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Cell' } })
  table.insert(copy_mode, { key = 'x', mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEndHoriz'})

  -- wezterm show-keys --lua
  keys = wezterm.gui.default_keys()
  table.insert(keys, { key = '.', mods = 'CTRL', action =  wezterm.action.ActivateTabRelative(1) })
  table.insert(keys, { key = ',', mods = 'CTRL', action =  wezterm.action.ActivateTabRelative(-1) })

  table.insert(keys, { key = 'c', mods = 'CTRL|CMD', action = wezterm.action.CopyTo 'Clipboard' })
  table.insert(keys, { key = "v", mods = "CMD|CTRL", action = wezterm.action{PasteFrom="Clipboard"}})
  -- PrimarySelection default: C-S-v
  table.insert(keys, { key = "v", mods = "SHIFT|CTRL", action = wezterm.action{PasteFrom="PrimarySelection"}})
  -- ActivateCopyMode default: C-S-x
  table.insert(keys, { key = '2', mods = 'CTRL', action =  wezterm.action.ActivateCopyMode })
  table.insert(keys, { key = 'v', mods = 'ALT', action =  wezterm.action.ActivateCopyMode })

  table.insert(keys, { key = 't', mods = 'CMD|CTRL', action =  wezterm.action.SpawnTab 'CurrentPaneDomain' })
  -- table.insert(keys, { key = 'w', mods = 'CMD|CTRL', action =  wezterm.action.CloseCurrentTab{ confirm = false } })
  table.insert(keys, { key = 'w', mods = 'CMD|CTRL', action =  wezterm.action.CloseCurrentPane{ confirm = false } })
   -- { key = 'v', mods = 'ALT', action =  wezterm.action.ActivateCopyMode },
   -- { key = 'j', mods = 'CMD', action =  wezterm.action.ActivatePaneDirection 'Down', },
   -- { key = 'k', mods = 'CMD', action =  wezterm.action.ActivatePaneDirection 'Up', },
   -- { key = 'R', mods = 'SHIFT|CTRL', action =  wezterm.action.ReloadConfiguration },
  table.insert(keys, { key = 'Enter', mods = 'CMD|CTRL', action =  wezterm.action.SpawnWindow })
  table.insert(keys,  {
    key = 'P',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs {
      label = 'open url',
      patterns = {
         "((ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\s{-}\\^⟨⟩`]+)",
        "(([\\w\\.\\-_/]+/)*[\\w\\-_\\.]+\\.[\\w]+(:\\d+)?)",
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        local cwd_uri = pane:get_current_working_dir()
        local cwd = ''
        local hostname = ''
        if cwd_uri then
           if type(cwd_uri) == 'userdata' then
              -- Running on a newer version of wezterm and we have
              -- a URL object here, making this simple!
           cwd = cwd_uri.file_path
           hostname = cwd_uri.host or wezterm.hostname()
           end
        end

        wezterm.log_info('opening: ' .. url)
        wezterm.open_with(cwd,'open-with')
      end),
    },
  })

  -- 使用emacsclient 打开scrollback
  table.insert(keys,  {key = 'F', mods = 'CTRL|SHIFT', action = act.EmitEvent 'edit-scrollback'})

-- 使用emacsclient 打开scrollback
wezterm.on('edit-scrollback', function(window, pane)
  -- Retrieve the current viewport's text.
  --
  -- Note: You could also pass an optional number of lines (eg: 2000) to
  -- retrieve that number of lines starting from the bottom of the viewport.
  -- local viewport_text = pane:get_lines_as_text(20000)         -- 有换行
  local viewport_text = pane:get_logical_lines_as_text(20000) -- 无换行


  -- Create a temporary file to pass to emacsclient
  local name = os.tmpname()
  local f = io.open(name, 'w+')
  f:write(viewport_text)
  f:flush()
  f:close()

  -- Open a new tab running vim and tell it to open the file
  window:perform_action(
    act.SpawnCommandInNewTab {
       -- 加一个非常大的行号，让emacsclient 跳转到文件末
      -- args = { 'open-with', name..":100000"},
      args = { 'emacsclient',"-t","+10000", name},
    },
    pane
  )

  -- Wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous wrt. running
  -- this script and are not awaitable, so we just pick a number.
  --
  -- Note: We don't strictly need to remove this file, but it is nice
  -- to avoid cluttering up the temporary directory.
  wezterm.sleep_ms(1000)
  os.remove(name)
end)


  -- { key = 'l', mods = 'CTRL|CMD', action =  wezterm.action.Multiple
  --   {
  --      wezterm.action.ClearScrollback 'ScrollbackAndViewport',
  --      wezterm.action.SendKey { key = 'L', mods = 'CTRL' },
  --   }
  -- },

end
config.key_tables = {copy_mode = copy_mode,search_mode=search_mode}
config.keys = keys
-- and finally, return the configuration to wezterm
return config
